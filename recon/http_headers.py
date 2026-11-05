#!/usr/bin/env python3
"""Fetch and display HTTP response headers for a list of hosts."""
import sys
import urllib.request

def probe_headers(host):
    url = f"https://{host}"
    try:
        req = urllib.request.Request(url, method="HEAD")
        with urllib.request.urlopen(req, timeout=10) as r:
            return r.status, dict(r.headers)
    except Exception as e:
        return None, str(e)

def main():
    hosts = [line.strip() for line in sys.stdin if line.strip()]
    for host in hosts:
        status, headers = probe_headers(host)
        print(f"\n=== {host} (HTTP {status}) ===")
        if isinstance(headers, str):
            print(f"  Error: {headers}")
        else:
            for key in ("server", "x-frame-options", "content-security-policy", "strict-transport-security"):
                val = headers.get(key, headers.get(key.title(), "N/A"))
                print(f"  {key}: {val}")

if __name__ == "__main__":
    main()
