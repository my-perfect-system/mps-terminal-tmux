#!/usr/bin/env bash
# Fedora/RHEL system packages for mps-terminal-tmux. Best-effort, sourced
# from install.sh; can also be run directly.
set -euo pipefail

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

# Toggles (default matches the odem.terminal.tmux role)
ENABLE_PACKAGES="${MPS_TMUX_ENABLE_PACKAGES:-1}"

if [[ "${ENABLE_PACKAGES}" = 1 ]]; then
    ${SUDO} dnf install -y tmux ruby rubygems
    # Fedora has no tmuxinator package — gem, mirrors the odem.terminal.tmux role.
    command -v tmuxinator >/dev/null 2>&1 || ${SUDO} gem install tmuxinator --no-user-install
fi

echo "mps-terminal-tmux Fedora packages installed"