#!/usr/bin/env bash
# Check security headers on a website.
URL="${1:?Usage: $0 <url>}"

echo "[*] Checking security headers for $URL"

curl -sI "$URL" 2>/dev/null | grep -iE "^(x-frame-options|content-security-policy|strict-transport-security|x-content-type-options|referrer-policy|permissions-policy|x-xss-protection)" || echo "[!] Could not fetch headers"

echo ""
echo "[*] Missing security headers check:"
curl -sI "$URL" 2>/dev/null | grep -qi "x-frame-options" || echo "  [!] X-Frame-Options missing"
curl -sI "$URL" 2>/dev/null | grep -qi "content-security-policy" || echo "  [!] Content-Security-Policy missing"
curl -sI "$URL" 2>/dev/null | grep -qi "strict-transport-security" || echo "  [!] Strict-Transport-Security missing"
curl -sI "$URL" 2>/dev/null | grep -qi "x-content-type-options" || echo "  [!] X-Content-Type-Options missing"
