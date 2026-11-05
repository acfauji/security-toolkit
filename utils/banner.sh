#!/usr/bin/env bash
# Reusable ASCII banner for scripts.
banner() {
    local text="${1:-Fauji Security}"
    local width=$(( ${#text} + 8 ))
    printf '%s\n' "$(printf '═%.0s' $(seq 1 "$width"))"
    printf '   %s\n' "$text"
    printf '%s\n' "$(printf '═%.0s' $(seq 1 "$width"))"
}
