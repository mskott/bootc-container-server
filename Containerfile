FROM quay.io/fedora/fedora-bootc:44
RUN dnf install -y \
    cockpit \
#    cockpit-machines \
    cockpit-podman \
    cockpit-selinux \
    rsync \
    tmux \
    borgbackup borgmatic \
    smartmontools \
    tcpdump \
    tuned \
    && dnf clean all && rm -f /var/log/dnf5.log

COPY units/ /usr/lib/systemd/system/
COPY 00-disable-pcie-aspm.toml /usr/lib/bootc/kargs.d/

RUN systemctl enable \
    var-local-media.mount \
    var-local-spinnaker.mount \
    var-local-marie.mount \
    var-local-pictures.mount \
    var-local-backups.mount \
    var-local-nextcloud.mount \
    cockpit.socket \
    podman-auto-update.timer \
    borgmatic.timer \
    acme-sh.timer \
    keycloak-backup.timer


COPY quadlets/ /usr/share/containers/systemd/
COPY Caddyfile /usr/local/etc/caddy/
COPY immich.yaml readeck.yaml caddy.yaml /usr/local/etc/

# Borgmatic setup
COPY borgmatic-common.yaml /etc/borgmatic/common.yaml
COPY borgmatic.d/ /etc/borgmatic.d/

RUN bootc container lint --no-truncate
