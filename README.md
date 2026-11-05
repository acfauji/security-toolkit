# Security Toolkit

Curated collection of security scripts, one-liners, and utilities for reconnaissance and hardening.

![Python](https://img.shields.io/badge/Python-3.8%2B-3776AB?style=flat-square&logo=python)
![Bash](https://img.shields.io/badge/Bash-4%2B-4EAA25?style=flat-square&logo=gnu-bash)

## 📁 Structure

```
├── recon/                 # Reconnaissance
│   ├── subdomain_enum.py  # Subdomain enum via crt.sh
│   ├── port_scan.sh       # Quick TCP port scan
│   └── http_probe.py      # HTTP/HTTPS status probing
├── hardening/             # Server hardening
│   ├── ssh_hardening.sh   # SSH hardening (key-only, no root)
│   └── server_check.sh    # Health & security checklist
├── osint/                 # OSINT automation
│   ├── email_osint.sh     # Email/username public lookups
│   └── metadata_extract.py # EXIF metadata extraction
└── utils/
    └── banner.sh          # Reusable ASCII banner
```

## 🚀 Quick Start

```bash
# Subdomain enumeration
python3 recon/subdomain_enum.py example.com

# Port scan (uses nmap if available)
./recon/port_scan.sh example.com "80,443,8080"

# Probe HTTP/HTTPS
cat hosts.txt | python3 recon/http_probe.py

# SSH hardening (run as root on target)
sudo ./hardening/ssh_hardening.sh
```

## ⚠️ Disclaimer

These tools are for **authorized security research and defensive purposes only**. Always obtain proper authorization before testing any system you do not own. The author is not responsible for misuse.

## 📄 License

MIT
