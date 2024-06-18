# Dofiles Configuration for Arch Linux



## Font confiration
_

This directory contains the dotfiles for my system


### Window Manager configuration
#### Requirement
    - [slstatus](https://git.suckless.org/slstatus)
    - [DWM](https://github.com/h3ndry/dwm/tree/master)
    - [rofi](https://archlinux.org/packages/extra/x86_64/rofi/)

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/dreamsofautonomy/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
### NOTE: Remember this

_create this directory `/etc/profile.d/open-ai.sh` he_

```
export CM_LAUNCHER=rofi

```


just so that I don't keep on googling the same thing

```
chsh -s $(which zsh)
```
