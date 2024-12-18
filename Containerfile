FROM quay.io/fedora/fedora-bootc:41
RUN systemctl enable podman-auto-update.timer
COPY usr /usr
COPY etc /etc
