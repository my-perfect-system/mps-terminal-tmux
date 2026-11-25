# mps-terminal-tmux

tmux and tmuxinator configuration of the my-perfect-system (mps) terminal stack.

## Install

| Method | Command |
| --- | --- |
| Default | `bootstrap.sh` clones to the system-wide mps repo dir and runs `install.sh` |
| Ansible | can be used by installing via the `odem.terminal.tmux` role of [odem-terminal](https://github.com/my-perfect-system/odem-terminal) |
| Standalone | clone the repo, then run `./install.sh` inside it; no network needed |

### Install (Default)

```bash
curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-terminal-tmux/main/bootstrap.sh | bash
```

All methods deploy `config/tmux` and `config/tmuxinator` to the current user's `~/.config`; one clone per host (`${MPS_REPO_DIR:-/srv/repo/github/my-perfect-system/mps}`), shared by all users.

## Usage

```bash
tls                             # tmux ls
tns work                        # tmux new -s work
tas work                        # tmux attach -t work
txs work                        # tmuxinator start (config/tmuxinator/work.yml)
```