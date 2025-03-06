FROM registry.access.redhat.com/ubi8

ADD tmp/firmware-ilo5-3.09-1.1.x86_64.rpm /opt/rpms/
ADD tmp/firmware-powerpic-gen10-1.1.4-3.1.x86_64.rpm /opt/rpms/
ADD tmp/firmware-smartarray-f7c07bdbbd-7.11-1.1.x86_64.rpm /opt/rpms/
ADD tmp/firmware-iegen10-0.2.3.0-5.1.x86_64.rpm /opt/rpms/
ADD tmp/firmware-spsgen10-04.01.05.002-2.1.x86_64.rpm /opt/rpms/
ADD tmp/firmware-system-u32-3.30_2024_07_31-1.1.x86_64.rpm /opt/rpms/
ADD tmp/firmware-nic-is-intel-1.31.0-1.1.x86_64.rpm /opt/rpms/
ADD tmp/firmware-nic-bcm-2.38.0-1.1.x86_64.rpm /opt/rpms/
ADD tmp/700Series /opt/hpefwupdate/
ADD tmp/firmware-nic-mellanox-641sfp28-private-16.35.3502-1.1.x86_64.rpm /opt/rpms/

RUN \
  dnf -y install kmod pciutils which mokutil && \
  dnf -y localinstall /opt/rpms/*.rpm && \
  rm -rf /opt/rpms && \
  dnf clean all && rm -rf /var/cache/dnf/*

ADD files/updateFW.sh /opt/hpefwupdate/
RUN chmod +x /opt/hpefwupdate/updateFW.sh

ENTRYPOINT [ "/bin/bash", "/opt/hpefwupdate/updateFW.sh" ]
USER 0:0
