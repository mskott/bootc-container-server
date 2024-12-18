FROM quay.io/fedora/fedora-bootc:41
RUN systemctl enable podman-auto-update.timer
COPY quadlets/ /usr/share/containers/systemd/
COPY etc /etc
