#!/usr/bin/env bash

# Exit immediately if any command fails
set -e

# ========================
# Configuration
# ========================
REPO_URL="https://github.com/chrislyons88/.df.git"
DOTFILES_DIR="$HOME/.df"
BACKUP_DIR_BASE="$HOME/__existing_dotfiles_backup"
BACKUP_DIR="$BACKUP_DIR_BASE/$(date +%s)"

# ========================
# Dependency lists
# ========================

MACOS_DEPENDENCIES_BASE=" git stow vim neovim tmux eza bat zoxide ripgrep fd fzf lazygit yazi htop pnpm ollama uv pyenv  jaq tealdeer gromgit/brewtils/taproom go"
TERMUX_DEPENDENCIES_BASE="git stow vim neovim tmux eza bat zoxide ripgrep fd fzf lazygit yazi htop pnpm ollama uv python jq  tealdeer python-numpy matplotlib nodejs rust"
UBUNTU_DEPENDENCIES_BASE="git stow vim"

MACOS_DEPENDENCIES_EXTRA=" fastfetch whois nmap pastel lynx dust duf dua-cli nushell postgresql@18 wireshark termshark lazydocker posting btop"
TERMUX_DEPENDENCIES_EXTRA="fastfetch whois nmap pastel lynx dust duf dua     nushell postgresql              termshark"

MACOS_DEPENDENCIES_FUN=" cmatrix cowsay figlet sl open-adventure jp2a lolcat yt-dlp libcaca mpv libsixel gstreamer asciiquarium"
TERMUX_DEPENDENCIES_FUN="cmatrix cowsay figlet sl open-adventure jp2a               termplay mplayer"
TERMUX_DEPENDENCIES_FUN_PIP="                                         lolcat yt-dlp"
  
MACOS_NETWORKING="bandwhich bmon trippy zenith netscanner"
MACOS_MONITORING="bottom glances cointop"

# temp env vars for mac pyenv
PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"

# ========================
# Functions
# ========================

detect_os() {
  if [[ "$OSTYPE" == "linux-android"* ]]; then
    echo "termux"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  elif [[ -f /etc/os-release ]]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
      echo "ubuntu"
    else
      echo "unsupported_linux"
    fi
  else
    echo "unsupported"
  fi
}

# ==========================

install_dependencies_macos() {
  echo "📦 Installing macOS dependencies..."

  echo "🛠️  Installing Xcode command-line tools..."
  xcode-select --install 2>/dev/null || true

  if ! command -v brew >/dev/null 2>&1; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
    echo >> /Users/$(whoami)/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  echo "🔄 Updating and upgrading Homebrew..."
  brew update && brew upgrade

  echo "📦 Installing base Homebrew packages..."
  brew install $MACOS_DEPENDENCIES_BASE

  echo "🟢 Installing NVM and Node LTS..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  source "$NVM_DIR/nvm.sh"
  nvm install --lts && nvm use --lts

  echo "🐍 Installing Python 3.12 via pyenv..."
  eval "$(pyenv init - zsh)"
  pyenv install 3.12 && pyenv global 3.12

  echo "🦀 Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

  echo "🧩 Installing GUI apps via Homebrew Cask..."
  (
    set +e  # disable strict mode in subshell only
    brew update --quiet
    brew install --quiet --cask \
      ghostty rectangle logi-options+ \
      google-chrome firefox \
      visual-studio-code ollama-app \
      docker-desktop wireshark-app pgadmin4 postman
      >/dev/null 2>&1
    echo "✅ Finished installing cask apps (ignored errors)."
  ) || echo "⚠️  Continuing despite cask install warnings..."
  # other potentials: notion 1password gimp figma blender

  read -p "💡 Install extra packages (networking, CLI tools)? [y/N] " confirm_extra
  [[ "$confirm_extra" =~ ^[Yy]$ ]] && {
    echo "📦 Installing extra packages..."
    brew install $MACOS_DEPENDENCIES_EXTRA
  }

  read -p "🎉 Install fun/toy packages (figlet, lolcat, etc)? [y/N] " confirm_fun
  [[ "$confirm_fun" =~ ^[Yy]$ ]] && {
    echo "📦 Installing fun packages..."
    brew install $MACOS_DEPENDENCIES_FUN
  }

  common_post_install_steps

  echo "🐍 Installing global Python libraries that must be installed in Mac-specific ways"
  pip install --upgrade pip
  pip install numpy matplotlib

  # brew install ollama
  # ollama serve
  # ollama pull deepseek-coder-v2:16b
}

install_dependencies_termux() {
  echo "📦 Installing Termux dependencies..."

  echo "📂 Setting up storage permissions..."
  termux-setup-storage || true

  echo "🔄 Updating and upgrading pkg..."
  pkg update -y && pkg upgrade -y

  echo "📋 Capturing default packages list..."
  apt-mark showmanual > termux-default-packages-list.txt

  echo "⚙️  Installing base development tools..."
  pkg install -y mandoc which zsh build-essential root-repo 

  

  echo "📦 Installing base packages..."
  pkg install -y $TERMUX_DEPENDENCIES_BASE

  read -p "💡 Install extra packages (networking, CLI tools)? [y/N] " confirm_extra
  [[ "$confirm_extra" =~ ^[Yy]$ ]] && {
    echo "📦 Installing extra packages..."
    pkg install -y $TERMUX_DEPENDENCIES_EXTRA
  }

  read -p "🎉 Install fun/toy packages (figlet, lolcat, etc)? [y/N] " confirm_fun
  [[ "$confirm_fun" =~ ^[Yy]$ ]] && {
    echo "📦 Installing fun packages..."
    pkg install -y $TERMUX_DEPENDENCIES_FUN
    echo "📦 Installing pip-based fun packages..."
    pip install --upgrade $TERMUX_DEPENDENCIES_FUN_PIP
  }

  echo "🔇 Hiding Termux MOTD..."
  touch ~/.hushlogin

  common_post_install_steps
}

install_dependencies_ubuntu() {
  echo "📦 Installing Ubuntu dependencies..."

  echo "🔄 Updating apt package list..."
  sudo apt update -y

  echo "📦 Installing base packages..."
  sudo apt install -y $UBUNTU_DEPENDENCIES_BASE

  common_post_install_steps
}

common_post_install_steps() {
  echo "🔧 Running common post-install steps..."

  echo "📚 Updating tldr cache..."
  tldr --update

  echo "🎨 Installing Yazi gruvbox-dark theme..."
  if ! ya pkg add bennyyip/gruvbox-dark; then
    echo "⚠️  Yazi theme already installed or failed to install — continuing..."
  fi

  echo "💎 Installing Powerlevel10k prompt..."
  if [ -d "$HOME/powerlevel10k" ]; then
    echo "✅ Powerlevel10k already present at ~/powerlevel10k"
  else
    if git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"; then
      echo "✨ Powerlevel10k cloned successfully."
    else
      echo "⚠️  Failed to clone Powerlevel10k (network issue or existing dir) — continuing anyway."
    fi
  fi

  echo "📁 Creating ~/code directory..."
  mkdir -p "$HOME/code"

  echo "🪄 Installing Euporie with uv..."
  uv tool install euporie
  uv tool update-shell

  echo "🌐 Installing global npm packages..."
  npm install -g pnpm@latest-10 mapscii

  echo "🐍 Installing global Python packages..."

  pip install jupyterlab ipykernel
  python -m ipykernel install --user --name python_global --display-name "Global $(python -V)"
}

# ==========================

backup_conflicts() {
  echo "Checking for conflicting files in \$HOME..."

  mkdir -p "$BACKUP_DIR_BASE"
  mkdir -p "$BACKUP_DIR"
  cd "$DOTFILES_DIR/HOME"

  for file in .* *; do
    # Skip special dirs
    [[ "$file" == "." || "$file" == ".." || "$file" == ".git" ]] && continue

    target="$HOME/$file"

    if [[ -e "$target" && ! -L "$target" ]]; then
      echo "⚠️  Backing up existing $target to $BACKUP_DIR"
      mv "$target" "$BACKUP_DIR/"
    fi
  done
}

clone_dotfiles_repo() {
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "Dotfiles repo already exists at $DOTFILES_DIR"
  else
    git clone "$REPO_URL" "$DOTFILES_DIR"
  fi
}

stow_dotfiles() {
  echo "Stowing dotfiles from root..."
  cd "$DOTFILES_DIR/HOME"
  stow -v -t ~ .
}


set_git_config() {
  read -p "Enter your Git name: " gitname
  read -p "Enter your Git email: " gitemail

  git config --global user.name "$gitname"
  git config --global user.email "$gitemail"

  echo "Git global config set!"
}


generate_ssh_key() {
  echo ""
  echo "🔐 SSH key setup"

  if [[ -f "$HOME/.ssh/id_ed25519.pub" ]]; then
    echo "✅ SSH key already exists at ~/.ssh/id_ed25519.pub"
  else
    read -p "Do you want to generate a new SSH key for this system? [y/N] " genkey
    if [[ "$genkey" =~ ^[Yy]$ ]]; then
      read -p "Enter your email for SSH key: " email
      mkdir -p ~/.ssh
      chmod 700 ~/.ssh

      ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519 -N ""

      echo "✅ SSH key generated at ~/.ssh/id_ed25519"

      if [[ "$OS" == "macos" ]]; then
        eval "$(ssh-agent -s)"
        ssh-add --apple-use-keychain ~/.ssh/id_ed25519
        pbcopy < ~/.ssh/id_ed25519.pub
        echo "📋 Public key copied to clipboard!"
        echo "🌐 Opening GitHub SSH key settings page..."
        open "https://github.com/settings/keys"
        echo "✅ Paste your key on the page that just opened."
      else
        echo "🔑 Here's your public SSH key:"
        cat ~/.ssh/id_ed25519.pub
      fi
    else
      echo "❌ Skipping SSH key generation."
    fi
  fi
}

setup_ssh_config() {
  echo ""
  echo "⚙️  Setting up ~/.ssh/config"

  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
  CONFIG_FILE="$HOME/.ssh/config"

  HOST_ALIAS="github"
  HOST_NAME="github.com"
  KEY_PATH="$HOME/.ssh/id_ed25519"

  # Check if an entry already exists
  if grep -q "Host $HOST_ALIAS" "$CONFIG_FILE" 2>/dev/null; then
    echo "✅ SSH config already has an entry for '$HOST_ALIAS'"
  else
    echo "🔧 Adding new SSH config entry for '$HOST_ALIAS' → $HOST_NAME"

    {
      echo ""
      echo "Host $HOST_ALIAS"
      echo "  HostName $HOST_NAME"
      echo "  User git"
      echo "  IdentityFile $KEY_PATH"
      echo "  IdentitiesOnly yes"
    } >> "$CONFIG_FILE"

    chmod 600 "$CONFIG_FILE"
    echo "✅ Entry added to ~/.ssh/config"
  fi
}

function post_clone_steps() {

  echo "🧰  Installing Neovim plugins and Mason packages..."
  nvim --headless "+Lazy! sync" "+MasonInstallAll" "+qall"
}

# ========================
# Main
# ========================

main() {
  echo "Detecting OS..."
  OS=$(detect_os)

  case "$OS" in
    termux)
      echo "Detected Termux"
      install_dependencies_termux
      ;;
    macos)
      echo "Detected macOS"
      install_dependencies_macos
      ;;
    ubuntu)
      echo "Detected Ubuntu"
      install_dependencies_ubuntu
      ;;
    *)
      echo "Unsupported OS: $OSTYPE"
      exit 1
      ;;
  esac

  clone_dotfiles_repo
  backup_conflicts
  stow_dotfiles
  set_git_config
  generate_ssh_key
  setup_ssh_config
  post_clone_steps

  echo "✅ Setup complete!"

  if [[ "$OS" == "macos" ]]; then
    echo "👻 Opening Ghostty..."
    open -a Ghostty
  fi
  if [[ "$OS" == "termux" ]]; then
    echo "🌀 Switching shell to Zsh..."
    echo "exec zsh" >> ~/.bashrc && source ~/.bashrc
  fi
}

main "$@"
