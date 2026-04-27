# Linux Server Baseline Check

Small Bash utility for a quick first-level Linux server health check.

The script prints the most important baseline information about a host and returns a non-zero exit code when required services are not active. It is useful for lab environments, virtual machines, Proxmox/ALT Linux test stands and quick post-deployment checks.

---

## What it checks

- static hostname
- primary IPv4 address
- default gateway
- root filesystem usage
- SSH service status
- QEMU Guest Agent service status
- final health status: `OK` or `WARN`

---

## Requirements

- Linux host with `bash`
- `hostnamectl`, `ip`, `df`, `systemctl`
- optional: `qemu-guest-agent`

The script is intentionally simple and does not install or change anything on the system.

---

## Quick start

```bash
chmod +x server-baseline-check.sh
./server-baseline-check.sh
```

Run with `sudo` only if your environment requires elevated access to service status or network details:

```bash
sudo ./server-baseline-check.sh
```

---

## Example output

```text
Hostname: srv1-cod
IPv4 address: 192.168.77.101
Default gateway: 192.168.77.1
Root filesystem usage: 18%

Service status:
  ssh: active
  qemu-guest-agent: active

Overall status: OK
```

---

## Exit codes

- `0` — required services are active
- `1` — at least one required service is inactive or unavailable

---

## Why this project exists

This is a small practice project for Linux administration and infrastructure checks. It can later be expanded into a bigger diagnostic tool with JSON output, multiple network interface support, package checks, disk alerts and Ansible integration.

---

## Possible improvements

- JSON output mode for automation
- support for selecting a network interface
- warning threshold for disk usage
- checks for DNS and internet connectivity
- Ansible role for installing the script on multiple hosts
