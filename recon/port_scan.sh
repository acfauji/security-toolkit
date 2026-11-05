#!/usr/bin/env bash
# Fast TCP port scan wrapper.
TARGET="${1:?Usage: $0 <target> [ports]}"
PORTS="${2:-21,22,23,25,53,80,110,143,443,445,993,995,3306,3389,5432,5900,8080,8443}"

if command -v nmap >/dev/null 2>&1; then
    echo "[*] Using nmap on $TARGET"
    nmap -sS -Pn -p "$PORTS" --open "$TARGET"
else
    echo "[*] Using bash /dev/tcp on $TARGET"
    for port in $(echo "$PORTS" | tr ',' ' '); do
        (exec 3<>/dev/tcp/"$TARGET"/"$port") 2>/dev/null \
            && echo "open: $TARGET:$port" \
            || true
    done
fi
