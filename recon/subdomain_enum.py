#!/usr/bin/env python3
"""Subdomain enumeration via Certificate Transparency logs (crt.sh)."""
import json
import sys
import urllib.request

def get_subdomains(domain):
    url = f"https://crt.sh/?q=%25.{domain}&output=json"
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=30) as resp:
            data = json.loads(resp.read().decode())
    except Exception as e:
        print(f"[!] Error querying crt.sh: {e}", file=sys.stderr)
        return set()

    subs = set()
    for entry in data:
        name = entry.get("name_value", "")
        for line in name.split("\n"):
            line = line.strip().lower()
            if line and line.endswith(f".{domain}") or line == domain:
                subs.add(line)
    return subs

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <domain>")
        sys.exit(1)
    domain = sys.argv[1].lower().strip()
    subs = get_subdomains(domain)
    for s in sorted(subs):
        print(s)
    print(f"\n[+] Total subdomains found: {len(subs)}", file=sys.stderr)
