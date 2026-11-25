#!/usr/bin/env bash
# Deploy mps-terminal-tmux to the current user's ~/.config/tmux and
# ~/.config/tmuxinator. Idempotent.
# OS-specific packages live in install-debian.sh / install-fedora.sh and are
# installed best-effort before the config deploy.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

#--- Distro detection -----------------------------------------------------------
detect_distro() {
    local id
    id="$(grep -sE '^ID=' /etc/os-release | head -1 | cut -d= -f2 | tr -d '\"')"
    case "${id}" in
        debian|ubuntu) echo "debian" ;;
        fedora|rhel)   echo "fedora" ;;
        *)
            if command -v apt-get >/dev/null 2>&1; then echo "debian"
            elif command -v dnf >/dev/null 2>&1; then echo "fedora"
            else echo "none"; fi ;;
    esac
}

#--- System: distro packages (best-effort; PACKAGES toggle read by the OS script) ---
case "$(detect_distro)" in
    debian) "${SRC}/install-debian.sh" || echo "==> WARN: install-debian.sh failed; continuing" ;;
    fedora)  "${SRC}/install-fedora.sh" || echo "==> WARN: install-fedora.sh failed; continuing" ;;
    *)       echo "==> Unsupported distro — skipping system packages" ;;
esac

#--- Per-user: config deploy ------------------------------------------------------
# Mirrors the odem.terminal.tmux role — 0600 files, 0700 dirs; keep cp -a.
install -d -m 0700 "${HOME}/.config/tmux" "${HOME}/.config/tmuxinator"
cp -a "${SRC}/config/tmux/." "${HOME}/.config/tmux/"
cp -a "${SRC}/config/tmuxinator/." "${HOME}/.config/tmuxinator/"

echo "mps-terminal-tmux deployed to ${HOME}/.config/tmux. Run: tmux"