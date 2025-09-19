# recycle-vm.sh

A simple Bash script to **recycle Proxmox Virtual Machines (VMs)** automatically.  
It attempts a graceful shutdown of a given VM, waits a configurable amount of time, and then starts it back up.  
Useful for scheduled maintenance, memory cleanup, or refreshing long-running services.  

---

## Features
- Accepts **VMID** as the first argument.  
- Optional **wait time** (in seconds) as the second argument (defaults to `60`).  
- Attempts graceful shutdown via `qm shutdown`.  
- Falls back to `qm stop` if the guest does not shut down cleanly.  
- Loops up to ~5 minutes, checking if the VM is stopped before starting it again.  

---

## Usage
```bash
recycle-vm.sh <VMID> [WAIT_SECS]
````

* `<VMID>` – The Proxmox VM ID to recycle. (Required)
* `[WAIT_SECS]` – Number of seconds to wait for graceful shutdown. (Optional, default: 60)

Example:

```bash
bash /usr/local/sbin/recycle-vm.sh 102 120
```

This will recycle VM **102**, giving it **120 seconds** to shut down before forcing a stop.

---

## Cron Example

You can schedule regular VM recycling with cron. For example:

```cron
0 4 * * * bash /usr/local/sbin/recycle-vm.sh 102 60
0 3 * * * bash /usr/local/sbin/recycle-vm.sh 103 60
```

This runs the script nightly at 3 AM and 4 AM for VMs `103` and `102`, respectively.

---

## Requirements

* Proxmox host with the `qm` CLI tool available.
* Run as a user with permissions to manage VMs (e.g., `root`).

---

## Author

Created by [**BeanGreen247**](https://github.com/BeanGreen247)
