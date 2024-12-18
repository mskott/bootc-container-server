FROM quay.io/fedora/fedora-bootc:41
RUN dnf install -y \
    cockpit \
    cockpit-machines \
    cockpit-podman \
    cockpit-selinux \
    cockpit-storaged \
    && dnf clean all
RUN systemctl enable \
    cockpit.socket \
    podman-auto-update.timer

COPY quadlets/ /usr/share/containers/systemd/
COPY etc /etc
