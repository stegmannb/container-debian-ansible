# container-debian-ansible

An Ubuntu container used for testing Ansible roles.
Can run with systemd as init.

## Tags

This repository currently supports the tags `latest`, `bookworm`, `jammy`, `bullseye` and `buster`.

The tags follow the conventions of the [official debian docker image](https://hub.docker.com/_/debian).

## Podman / Docker example

```bash
# Create the container without systemd and log in
podman run --interactive --tty ghcr.io/stegmannb/container-debian-ansible:latest
```

## Podman / Docker systemd example

```bash
# Create the container with systemd
podman run --detach --entrypoint /lib/systemd/systemd --cap-add SYS_ADMIN --volume /sys/fs/cgroup:/sys/fs/cgroup:ro --systemd=true ghcr.io/stegmannb/container-debian-ansible:latest
# Log into the container
podman exec --latest --interactive --tty /bin/bash
# Or use short flags
podman exec -itl /bin/bash
```

## Molecule systemd example

```yaml
driver:
  name: containers

platforms:
  - name: molecule-debian-systemd
    image: ghcr.io/stegmannb/container-debian-ansible:latest
    groups:
      - debian
    command: /lib/systemd/systemd
    tmpfs:
      - /run
      - /tmp
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    capabilities:
      - SYS_ADMIN
```

## Molecule example

```yaml
driver:
  name: containers

platforms:
  - name: molecule-debian-systemd
    image: ghcr.io/stegmannb/container-debian-ansible:latest
    groups:
      - debian
```

## Ansible systemd example

```yaml
- name: Create Ubuntu test container
  containers.podman.podman_container:
    name: test-debian
    image: ghcr.io/stegmannb/container-debian-ansible:latest
    groups:
      - debian
    command: /lib/systemd/systemd
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    capabilities:
      - SYS_ADMIN
```

## Ansible example

```yaml
- name: Create Ubuntu test container
  containers.podman.podman_container:
    name: test-debian
    image: ghcr.io/stegmannb/container-debian-ansible:latest
    groups:
      - debian
```
