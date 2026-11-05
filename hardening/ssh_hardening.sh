#!/usr/bin/env bash
# SSH hardening for Ubuntu/Debian servers.
set -euo pipefail
SSHD_CONFIG="/etc/ssh/sshd_config"

echo "[*] Applying SSH hardening to $SSHD_CONFIG"

backup() {
    if [ ! -f "${SSHD_CONFIG}.bak" ]; then
        cp "$SSHD_CONFIG" "${SSHD_CONFIG}.bak"
        echo "[+] Backup created: ${SSHD_CONFIG}.bak"
    fi
}

apply() {
    local key="$1" value="$2"
    if grep -qE "^#?${key}" "$SSHD_CONFIG"; then
        sed -i "s/^#\?${key}.*/${key} ${value}/" "$SSHD_CONFIG"
    else
        echo "${key} ${value}" >> "$SSHD_CONFIG"
    fi
    echo "[+] Set ${key} ${value}"
}

backup
apply "PermitRootLogin" "no"
apply "PasswordAuthentication" "no"
apply "PubkeyAuthentication" "yes"
apply "X11Forwarding" "no"
apply "MaxAuthTries" "3"
apply "ClientAliveInterval" "300"
apply "ClientAliveCountMax" "2"
apply "AllowTcpForwarding" "no"

echo "[*] Restarting sshd (review config first: sshd -t)"
if sshd -t; then
    systemctl restart sshd
    echo "[+] sshd restarted"
else
    echo "[!] Config invalid - NOT restarting. Restore with: cp ${SSHD_CONFIG}.bak ${SSHD_CONFIG}"
    exit 1
fi
