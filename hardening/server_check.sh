#!/usr/bin/env bash
# Quick server health/security checklist.
echo "=== System Info ==="
uname -a
uptime

echo ""
echo "=== Disk Usage ==="
df -h / | awk 'NR==1 || NR==2'

echo ""
echo "=== Running Services ==="
systemctl list-units --type=service --state=running --no-pager | head -20

echo ""
echo "=== Listening Ports ==="
ss -tlnp 2>/dev/null | head -25

echo ""
echo "=== Failed Logins (last 24h) ==="
journalctl _COMM=sshd --since "24 hours ago" 2>/dev/null | grep -c "Failed password" || echo "0"

echo ""
echo "=== Pending Updates ==="
apt list --upgradable 2>/dev/null | tail -n +2 | wc -l
