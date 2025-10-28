# .df: Multi-platform development environment

`.df` is a collection of install scripts and configuration files meant to both bootstrap a new development environment on MacOS or Termux (Android), and preserve the configuration in an easily-reproducable way as it evolves. This solution uses GNU stow to symlink your dotfiles from the git repo to the appropriate locations. All tools are customized to use the Gruvbox Dark theme. 

The only changes one would have to make for this to work for them would be to replace the two mentions of the Github URL in the install script and the `curl` install command in this README. The plan is to make that dynamic in the near future. Ubuntu support is underway.

# Prerequisites

## Termux
- Get the latest Termux APK from the Termux Github releases page: https://github.com/termux/termux-app/releases
- Get the latest termux-styling APK from its Github release page: https://github.com/termux/termux-styling/releases
- Install them both (you'll have to enable installing from unknown sources)
- Once installed, open Termux then press and hold anywhere on the terminal screen until the menu appears, and select "More..."
  - Select "Style", then "Color", and choose "Gruvbox Dark"
  - Then select "Choose Font" and choose any nerd font you like. My default is "Roboto Mono"
- Then go back to the terminal in preparation for the install step

## OSX
- Open the built-in Terminal app
- Type `sudo ls` (or any other arbitrary command) and enter your password to ensure the install has the correct premissions

# Install

It's surprisingly simple, all you need to do is run this curl command and respond to any prompts:

```sh
curl -fsSL https://raw.githubusercontent.com/chrislyons88/.df/refs/heads/main/install.sh | sh
```
This will do the following:
- Detect if your OS is a supported target, and if so, continue down its specific path
- Install base dependencies from main and secondary (pip, cargo, uv) package managers. You can see the list at the top of `install.sh`.
- Ask whether you want to install extra packages. These are not necessary for the base config, but they are useful packages I generally like installed.
- Ask whether you want to install fun packages. These are purely fun like lolcat, figlet, cmatrix, cowsay, etc.
- Install and configure a powelevel10k prompt
- Clone this repo to `~/.df`
- Backup any existing files that would be overwritten to `$HOME/__existing_dotfiles_backup/$(date +%s)`
- Use GNU stow to symlink the config files in this repos `HOME` directory to the system home `~/`
- Prompt you for your git name and email to set that config for you
- Ask whether you want to create a new SSH key, and if you do, it will copy the new public key and open the Github settings page where you add your keys.
- Add an entry for Github to your `.ssh/config` if it doesn't already exist
- Load your tmux theme and headlessly install neovim Lazy and Mason packages
- Create a `~/code` directory if it doesn't exist
- On Mac, it will launch Ghostty for you

# Digging further
You can get more info on the tools installed and the aliases, functions, and env variables being set by looking at `install.sh` and `HOME/.zshrc`
