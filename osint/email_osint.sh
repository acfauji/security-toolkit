#!/usr/bin/env bash
# Email-to-username / existence OSINT checks (public sources only).
EMAIL="${1:?Usage: $0 <email>}"
USERNAME="${EMAIL%%@*}"
DOMAIN="${EMAIL##*@}"

echo "[*] Username: $USERNAME"
echo "[*] Domain: $DOMAIN"
echo ""
echo "=== Check GitHub username existence ==="
curl -s -o /dev/null -w "github.com/$USERNAME -> HTTP %{http_code}\n" "https://github.com/$USERNAME" || true

echo ""
echo "=== Check domain MX records ==="
command -v dig >/dev/null 2>&1 && dig +short MX "$DOMAIN" | head -5 || true

echo ""
echo "=== Check domain has A/AAAA ==="
command -v dig >/dev/null 2>&1 && dig +short A "$DOMAIN" | head -3 || true
