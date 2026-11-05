#!/usr/bin/env bash
# Check SSL/TLS configuration of a target.
TARGET="${1:?Usage: $0 <host:port>}"

echo "[*] Checking TLS configuration for $TARGET"

if command -v openssl >/dev/null 2>&1; then
    echo ""
    echo "[*] Certificate info:"
    echo | openssl s_client -connect "$TARGET" -servername "$TARGET" 2>/dev/null | openssl x509 -noout -subject -issuer -dates 2>/dev/null || true

    echo ""
    echo "[*] Supported TLS versions:"
    for ver in ssl3 tls1 tls1_1 tls1_2 tls1_3; do
        if echo | openssl s_client -"$ver" -connect "$TARGET" 2>/dev/null | grep -q "Cipher"; then
            echo "  $ver: SUPPORTED"
        else
            echo "  $ver: not supported"
        fi
    done
else
    echo "[!] openssl not found"
fi
