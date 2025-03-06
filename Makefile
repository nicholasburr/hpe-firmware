.PHONY: build update clean

HTTP_PROXY := http://127.0.0.1:3129
BUILD_EXTRA_VARS ?=
UPDATE_EXTRA_VARS ?=
UPDATE_LIMIT ?=

build:
	ansible-playbook build.yaml $(BUILD_EXTRA_VARS)

update: 
	ansible-playbook update.yaml -i inventory/nodes.py -e $(UDPATE_EXTRA_VARS) -l $(UPDATE_LIMIT)

clean:
	@echo "Cleaning up..."
	@rm -rf tmp/*
	@rm Containerfile
	@echo "Clean complete."