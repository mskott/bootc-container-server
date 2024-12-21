FROM quay.io/fedora/fedora-bootc:41
RUN dnf install -y \
    NetworkManager-wifi \
    NetworkManager-wwan \
    wpa_supplicant \
    wireless-regdb \
    cockpit \
#    cockpit-machines \
    cockpit-podman \
    cockpit-selinux \
    && dnf clean all
RUN systemctl enable \
    cockpit.socket \
    podman-auto-update.timer

COPY quadlets/ /usr/share/containers/systemd/
COPY etc /usr/local/etc

RUN bootc container lint