#!/usr/bin/env bash
set -euo pipefail

VMID="${1:?Usage: recycle-vm.sh <VMID> [WAIT_SECS]}"
WAIT_SECS="${2:-60}"

# Ask guest to shut down cleanly (ACPI). Fallback to hard stop if it won't.
if ! qm shutdown "$VMID" --timeout "$WAIT_SECS"; then
  echo "Graceful shutdown timed out; forcing stop..."
  qm stop "$VMID"
fi

# Optional: wait until it's actually down (max ~5 min)
for _ in $(seq 1 30); do
  if qm status "$VMID" | grep -q "stopped"; then
    break
  fi
  sleep 10
done

# Start it back up
qm start "$VMID"
