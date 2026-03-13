# Dotfiles for Arch Linux

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/), featuring [HyDE](https://github.com/HyDE-Project/HyDE) (Hyprland Desktop Environment) as the desktop environment.

## What's Included

- **Window Manager:** [Hyprland](https://hyprland.org/) via HyDE
- **Terminal:** [Alacritty](https://alacritty.org/)
- **Shell:** [Zsh](https://www.zsh.org/)
- **Editor:** [Neovim](https://neovim.io/)
- **Multiplexer:** [Tmux](https://github.com/tmux/tmux)
- **File Manager:** [nnn](https://github.com/jarun/nnn)
- **PDF Viewer:** [Zathura](https://pwmt.org/projects/zathura/)
- **System Monitor:** [btop](https://github.com/aristocratos/btop)
- **Keyboard Remapping:** [KMonad](https://github.com/kmonad/kmonad)
- **Launcher:** [Rofi](https://github.com/davatorium/rofi)

## Requirements

Ensure you have the following installed on your system:

```bash
pacman -S git stow
```

## Installation

Clone the dotfiles repo into your `$HOME` directory:

```bash
git clone git@github.com:simanga-dev/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Then use GNU Stow to create symlinks:

```bash
stow .
```

## Notes

Set Zsh as the default shell:

```bash
chsh -s $(which zsh)
```

Create `/etc/profile.d/env.sh` for environment variables:

```bash
export CM_LAUNCHER=rofi
```
