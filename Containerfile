FROM quay.io/fedora/fedora-bootc:41
RUN dnf install -y \
    NetworkManager-wifi \
    wpa_supplicant \
    wireless-regdb \
    cockpit \
#    cockpit-machines \
    cockpit-podman \
    cockpit-selinux \
    rsync \
    && dnf clean all
RUN systemctl enable \
    cockpit.socket \
    podman-auto-update.timer

COPY mounts/ /usr/lib/systemd/system/

RUN systemctl enable \
    var-local-media.mount \
    var-local-spinnaker.mount \
    var-local-marie.mount 

COPY quadlets/ /usr/share/containers/systemd/

RUN bootc container lint