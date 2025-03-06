#!/usr/bin/env python3

import json
import os
from kubernetes import client, config

def get_k8s_nodes():
    """Retrieve a list of Kubernetes nodes, their labels, and annotations."""
    # Load the Kubernetes configuration from the default KUBECONFIG location
    kubeconfig_path = os.path.expanduser("~/.kube/config")
    config.load_kube_config(config_file=kubeconfig_path)

    # Create a CoreV1Api instance to interact with the cluster
    v1 = client.CoreV1Api()

    # Retrieve the list of nodes
    nodes = v1.list_node().items

    # Create a dictionary with node names, their labels, and annotations
    node_info = {}
    for node in nodes:
        node_name = node.metadata.name
        node_labels = node.metadata.labels
        node_annotations = node.metadata.annotations

        # Convert the labels and annotations dictionaries into lists of key-value pairs
        node_labels_list = [{"key": k, "value": v} for k, v in node_labels.items()]
        node_annotations_list = [{"key": k, "value": v} for k, v in node_annotations.items()]
        
        node_info[node_name] = {
            "labels": node_labels_list,
            "annotations": node_annotations_list,
            "label_dict": node_labels  # Keep label dictionary to easily check for roles
        }

    return node_info

def get_baremetal_host_product_names():
    """Retrieve the productName from baremetalhost.metal3.io for each host."""
    # Create a CustomObjectsApi instance to interact with custom resources
    api = client.CustomObjectsApi()

    # Retrieve the baremetalhost objects
    namespace = "openshift-machine-api"  # Replace with the appropriate namespace for your cluster
    group = "metal3.io"
    version = "v1alpha1"
    plural = "baremetalhosts"

    try:
        baremetal_hosts = api.list_namespaced_custom_object(
            group=group, version=version, namespace=namespace, plural=plural
        )
    except client.exceptions.ApiException as e:
        print(f"Error fetching baremetal hosts: {e}")
        return {}

    # Extract the productName for each host
    product_names = {}
    for host in baremetal_hosts.get("items", []):
        name = host["metadata"]["name"]
        product_name = host.get("status", {}).get("hardware", {}).get("product", {}).get("name", "Unknown")
        product_names[name] = product_name

    return product_names

def generate_ansible_inventory():
    """Generate an Ansible inventory with dynamic groups based on node-role.kubernetes.io/* labels."""
    # Get the list of node names, labels, and annotations
    nodes_info = get_k8s_nodes()

    # Get the product names for baremetal hosts
    baremetal_product_names = get_baremetal_host_product_names()

    # Initialize inventory structure with _meta and 'all' group
    inventory = {
        "all": {
            "hosts": [],
            "vars": {}
        },
        "_meta": {
            "hostvars": {}
        }
    }

    # Add nodes to the appropriate groups and assign their labels and annotations as hostvars
    for node_name, info in nodes_info.items():
        # Add node to the 'all' group
        inventory["all"]["hosts"].append(node_name)

        # Iterate through labels and create groups for each node-role.kubernetes.io/<role> label
        for label_key, label_value in info["label_dict"].items():
            if label_key.startswith("node-role.kubernetes.io/"):
                role = label_key.split("/")[-1]
                group_name = f"{role}"

                # Add the node to the corresponding role group
                if group_name not in inventory:
                    inventory[group_name] = {"hosts": [], "vars": {}}
                inventory[group_name]["hosts"].append(node_name)

        # Add node-specific hostvars, including productName if available
        inventory["_meta"]["hostvars"][node_name] = {
            "labels": info["labels"],
            "annotations": info["annotations"],
            "productName": baremetal_product_names.get(node_name, "Unknown")
        }

    # Output the inventory in JSON format for Ansible to use
    print(json.dumps(inventory, indent=2))

if __name__ == "__main__":
    generate_ansible_inventory()