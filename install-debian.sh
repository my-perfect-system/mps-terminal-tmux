#!/usr/bin/env bash
# Debian/Ubuntu system packages for mps-terminal-tmux. Best-effort, sourced
# from install.sh; can also be run directly.
set -euo pipefail

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

# Toggles (default matches the odem.terminal.tmux role)
ENABLE_PACKAGES="${MPS_TMUX_ENABLE_PACKAGES:-1}"

if [[ "${ENABLE_PACKAGES}" = 1 ]]; then
    ${SUDO} apt-get install -y tmux tmuxinator
fi

echo "mps-terminal-tmux Debian packages installed"