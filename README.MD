# KaliShell
## Note: This project is still working progress. PRs are vary appreciate.
## What is KaliShell?
KaliShell is an easy way setup of [kali linux docker](https://hub.docker.com/r/kalilinux/kali-rolling) which offers:
1. All the [most used tools](https://www.kali.org/tools/kali-meta/#kali-linux-headless) already installed.
2. 3D acceleration support by a NVIDIA dedicated GPU (if you don't have a NVIDIA GPU take a look to [Alternative Configurations](#alternative-configurations)).
3. Aliases for open kali docker image shell in the current directory.

It provides 2 different `aliases`:
1. openKaliHere --> it runs KaliShell on the current directory
2. openKaliHereSudo --> Use this carefully only if you know what you are doing (You are giving privilaged escalation to you docker image).

## Examples
TODO

## Installation
### Dependency
The installation script considers that you have the following dependency installed:
1. [Docker](https://www.docker.com/)
2. [Bash](https://www.gnu.org/software/bash/) or [Zsh](https://www.zsh.org/)
3. [yay](https://github.com/Jguer/yay) (Only for Archlinux users)

For installation you just need to clone the repository and run the file `setup.sh` with the settings you prefer.
The script automatically support Arch, Debian and Fedora linux based distro. If you don't use one of this it works anyway but you have to edit the script manually for making it works.

```
git clone https://github.com/LorenzoMorelli/KaliShell.git
cd KaliShell
```
And then for the FULL installation (both includes 3D Acceleration and aliases in `.bashrc`):
```
sh ./setup.sh --nvidia-gpu --bash
```
If you are a `ZSH` user:
```
sh ./setup.sh --nvidia-gpu --zsh
```

### Alternative Configurations
For installing ONLY `NVIDIA 3D ACCELERATION` without aliases:
```
sh ./setup.sh --nvidia-gpu
```
If you DON'T have a NVIDIA GPU you can install without NVIDIA acceleration:
```
sh ./setup.sh --bash
```
## TODO List
1. Implement and test Fedora setup script
2. Upload example pictures/videos
