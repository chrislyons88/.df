```bash
sudo apt update && sudo apt upgrade

# issue with no clipboard: works fine if running in tmux
sudo apt install build-essential pkg-config libssl-dev zsh tmux htop btop eza ranger fzf bat ripgrep curl gdu duf tldr jq lua5.1 postgresql postgresql-contrib
sudo apt install cowsay neofetch cmatrix figlet lynx sl lolcat
sudo snap install --classic nvim

curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
 
sudo chsh -s $(which zsh) $USE

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# copy tmux config over

# install nvchad
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# NVM 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

nvm install node


LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

git config --global user.name "Chris Lyons" && git config --global user.email "chris.lyons@redjack.com"

curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Automatically forward SSH agent to tmux
if [ -z "$SSH_AUTH_SOCK" ] && [ -n "$TMUX" ]; then
  export SSH_AUTH_SOCK=$(ps aux | grep ssh-agent | grep -v grep | awk '{print $12}' | head -n 1)
fi


# quick install on MacOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# install Posting (will also quickly install Python 3.12 if needed)
uv tool install --python 3.12 posting

cargo install rainfrog
```
