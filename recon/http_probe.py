#!/usr/bin/env python3
"""Probe HTTP/HTTPS status codes for a list of hosts."""
import concurrent.futures
import sys
import urllib.request

def probe(host):
    results = {}
    for scheme in ("https", "http"):
        url = f"{scheme}://{host}"
        try:
            req = urllib.request.Request(url, method="HEAD")
            with urllib.request.urlopen(req, timeout=10) as r:
                results[scheme] = r.status
        except Exception as e:
            code = getattr(e, "code", None)
            results[scheme] = code or "ERR"
    return host, results

def main():
    hosts = [line.strip() for line in sys.stdin if line.strip()]
    with concurrent.futures.ThreadPoolExecutor(max_workers=10) as ex:
        for host, results in ex.map(probe, hosts):
            print(f"{host}: https={results.get('https')} http={results.get('http')}")

if __name__ == "__main__":
    main()
