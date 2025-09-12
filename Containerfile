FROM quay.io/fedora/fedora-bootc:42
RUN dnf install -y \
    cockpit \
#    cockpit-machines \
    cockpit-podman \
    cockpit-selinux \
    rsync \
    tmux \
    borgbackup borgmatic \
    && dnf clean all && rm -f /var/log/dnf5.log
RUN systemctl enable \
    cockpit.socket \
    podman-auto-update.timer

COPY mounts/ /usr/lib/systemd/system/
COPY 00-disable-pcie-aspm.toml /usr/lib/bootc/kargs.d/

RUN systemctl enable \
    var-local-media.mount \
    var-local-spinnaker.mount \
    var-local-marie.mount \
    var-local-pictures.mount

COPY quadlets/ /usr/share/containers/systemd/
COPY Caddyfile /usr/local/etc/caddy/
COPY immich.yaml readeck.yaml caddy.yaml /usr/local/etc/

RUN bootc container lint