ARG versiontag="latest"
FROM docker.io/debian:${versiontag}

RUN apt-get update && \
    apt-get install --assume-yes --no-install-recommends \
        sudo \
        bash \
        python3 \
        software-properties-common \
        rsyslog \
        systemd \
        systemd-cron && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    touch -d "2 hours ago" /var/lib/apt/lists && \
    useradd --system --create-home --shell /bin/bash ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/ansible-sudo

RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

RUN rm -f /lib/systemd/system/systemd*udev* \
  && rm -f /lib/systemd/system/getty.target

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]
