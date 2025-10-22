# ===========================
# powerline prompt
# ===========================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# eval "$(starship init zsh)"
# ========================
#  aliases and functions
# ========================
export XDG_CONFIG_HOME="$HOME/.config"

# make syntax highlighting in bat follow the rest of our color theme
export BAT_THEME="gruvbox-dark"

# use nvim
alias v="nvim"
# alias vim="nvim"
export EDITOR="nvim"
export VISUAL="nvim"

# getting around, replace cd with zoxide
alias ..="cd .."
function md() { mkdir $1 && cd $1 }
alias cd="z"

# listing directories, replace ls with eza
alias ls="eza -a --icons --group-directories-first"
# alias es="eza -a --icons --group-directories-first"
alias et="eza -a --icons --tree"
alias etl="eza --icons --tree -alh"
alias ll="eza --icons -alh --group-directories-first"

# replace cat with bat
# alias cat="bat"

# editing rc and sourcing it
alias fr="source ~/.zshrc && clear"
alias rc="nvim ~/.zshrc && source ~/.zshrc"
alias sshc="nvim ~/.ssh/config"
alias gc="nvim ~/.config/ghostty/config"

# Git 
alias gs="git status"

# alias so it's consistent across OSs
alias gdu="gdu-go"

# fzf and rg workflows
# - fzf with preview
alias fz="fzf --preview 'bat --color=always --style=numbers,changes,header {}' | xargs nvim"
# - fzf for files containing a specific string
function rgf() {
  rg -l $1 | fzf --preview "rg --color=always --line-number '$1' {}"
}
# - open files in vim via fzf
# alias fzv="fzp | xargs nvim" : redundant, use ctrl+t or nvim **<tab>
# function rzv() {
#   rgf "$1" | xargs nvim
# }

# networking tools
function trippy() {
  sudo trip $1 -r cloudflare -G $XDG_CONFIG_HOME/_resources/GeoLite2-City.mmdb -yz
}
# network monitoring tools: bmon, trippy, netscanner, bandwhich, oryx (linux only), 

# data science
alias euporie-nb="euporie-notebook --graphics kitty --force-graphics --kernel python3"

# permissions
alias octal="stat -f %A"

# ye olde ways: now using rg and fd for these
alias grep="grep --color=auto"
function ff() { find . -type f -name $1 }

# just for fun
alias fish="asciiquarium"
alias fishcat="asciiquarium | lolcat"
function figcat() {
  figlet -w 999 $1 | lolcat
}
alias slol="sl | lolcat"


# ===================
# fzf
# ===================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ===================
# Zoxide
# ===================
eval "$(zoxide init zsh)"

# ===================
# NVM
# ===================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ===================
# rust
# ===================
# export OPENSSL_DIR=$(brew --prefix openssl@3)
# export OPENSSL_INCLUDE_DIR=$OPENSSL_DIR/include
# export OPENSSL_LIB_DIR=$OPENSSL_DIR/lib
export PATH="/opt/homebrew/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:/opt/homebrew/share/pkgconfig"
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export OPENSSL_DIR="/opt/homebrew/opt/openssl@3"
export OPENSSL_INCLUDE_DIR="$OPENSSL_DIR/include"
export OPENSSL_LIB_DIR="$OPENSSL_DIR/lib"

export LIBRARY_PATH="/opt/homebrew/lib"
# export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"
# brew install gromgit/brewtils/taproom
# ===================
# ascii images and video
# ===================
# brew install jp2a gstreamer libsixel
# cargo install termplay --features="bin"
# eval "$(/opt/homebrew/bin/brew shellenv)"

# ===================
# PATH 
# ===================

export PATH="/Users/christopher/.local/bin:$PATH"


# cloud stuff
# ===================

export PATH=$PATH:/usr/local/bin/aws:/usr/local/bin/aws_completer:sdk_path/bin/gcloud

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/christopher/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/christopher/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/christopher/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/christopher/google-cloud-sdk/completion.zsh.inc'; fi

# python 
. "$HOME/.local/bin/env"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
