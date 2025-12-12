FROM quay.io/fedora/fedora-bootc:42
COPY grafana.repo /etc/yum.repos.d/
RUN dnf install -y \
    cockpit \
#    cockpit-machines \
    cockpit-podman \
    cockpit-selinux \
    rsync \
    tmux \
    borgbackup borgmatic \
    smartmontools \
    alloy \
    && dnf clean all && rm -f /var/log/dnf5.log
RUN systemctl enable \
    cockpit.socket \
    podman-auto-update.timer \
    alloy.service

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
COPY tmpfiles.d/alloy.conf /usr/local/lib/tmpfiles.d/alloy.conf
COPY sysusers.d/alloy.conf /usr/local/lib/sysusers.d/alloy.conf

RUN bootc container lint --no-truncate
