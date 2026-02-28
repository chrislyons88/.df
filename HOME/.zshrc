# ===========================
# powerline prompt
# ===========================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ========================
# environment variables
# ========================
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim
export VISUAL=nvim
# export BAT_THEME="gruvbox-dark"

# add anything that shouldn't be in the repo to ~/.secrets
[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"

# ============================
# global tool evals & sources
# ============================
eval "$(zoxide init zsh)" # zoxide init
source <(fzf --zsh) # Set up fzf key bindings and fuzzy completion

# ========================
# PATH changes
# ========================
export PATH="$PATH:$HOME/.volta/bin"

# ========================
#  aliases and functions
# ========================

# getting around
alias cd="z"
alias ..="cd .."
function md() {
  mkdir $1 && cd $1
}

# viewing files and folders
alias ls="eza --icons --git --group-directories-first -a"
alias ll="eza --icons --git --group-directories-first --git -alh"
alias et="eza --icons --tree -a --git-ignore"
alias etl="eza --icons --git --group-directories-first --git-ignore -alh --tree"

# quick edit config files
alias rc="nvim ~/.zshrc && source ~/.zshrc"
alias fr="source ~/.zshrc && clear"
alias gc="nvim ~/.config/ghostty/config"
alias sshc="nvim ~/.ssh/config"

# git aliases
alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gcm="git commit -m"

# neovim
alias v="nvim"
alias vc="nvim ~/.local/share/nvim/lazy/base46/lua/base46/themes/gruvbox.lua"

# fzf
alias ff="fzf --preview 'bat --color=always --style=numbers,changes,header {}' | xargs nvim"
function fw() {
  local query="${*:-}"
  local selected file line
  local preview_cmd
  preview_cmd='bat --color=always --style=numbers,changes,header --highlight-line {2} {1} \
    | rg --color=always --ignore-case --context 5 -- "$(printf "%s" {q} | sed "s/[^^]/[&]/g; s/\^/\\^/g")"'

    # Main ripgrep → fzf pipeline
    selected="$(
      rg --column --line-number --no-heading --color=always --smart-case "${query}" \
        | fzf --ansi --delimiter : \
        --preview "$preview_cmd" \
        --preview-window=up:60%:wrap \
        --query "$query"
      )"

      [[ -z "$selected" ]] && return 0

      file="$(echo "$selected" | cut -d: -f1)"
      line="$(echo "$selected" | cut -d: -f2)"
      [[ -n "$file" ]] && ${EDITOR:-nvim} +"${line}" "$file"
}

# postgres
alias pgstart="pg_ctl -D $PREFIX/var/lib/postgresql start"
alias pgstop="pg_ctl -D $PREFIX/var/lib/postgresql stop"

# networking tools
function trippy() {
  sudo trip $1 -r cloudflare -G $XDG_CONFIG_HOME/_resources/GeoLite2-City.mmdb -yz
}
# network monitoring tools: bmon, trippy, netscanner, bandwhich, oryx (linux only), 

# data science
alias euporie-notebook="euporie-notebook --config $XDG_CONFIG_HOME/euporie/config.json"
# alias euporie-nb="euporie-notebook --graphics kitty --force-graphics --kernel python3"

# permissions
alias octal="stat -f %A"

# just for fun
function ytdl() {
  yt-dlp -o - -f best "$1"
}
function figcat() {
  figlet -w 999 $1 | lolcat
}
alias fish="asciiquarium"
alias fishcat="asciiquarium | lolcat"
alias starwars="telnet towel.blinkenlights.nl"
alias slol="sl | lolcat"

# ========================
# termux-specific
# ======================== 
if [[ "$OSTYPE" == "linux-android"* ]]; then

  # override fzf preview window size/location for mobile
  alias ff="fzf --preview 'BAT_THEME=$BAT_THEME bat --color=always --style=numbers,changes {}' --preview-window=up:60%:wrap | xargs nvim"

  # add a quick way to turn the on-screen keyboard off
  alias keyson="sed -i '/^extra-keys/d' ~/.termux/termux.properties && termux-reload-settings"
  alias keysoff="echo 'extra-keys = []' >> ~/.termux/termux.properties && termux-reload-settings"

  # view explicitely installed termux packages
  alias apt-new='comm -23 <(apt-mark showmanual | sort) <(sort ~/termux-default-packages-list.txt)'

  # for uv installed euporie
  export PATH="/data/data/com.termux/files/home/.local/bin:$PATH"
fi

# ========================
# mac-specific
# ======================== 
if [[ "$(uname)" == "Darwin" ]]; then
 
  # mac python
  # . "$HOME/.local/bin/env"
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"

  # mac node.js
  # export NVM_DIR="$HOME/.nvm"
  # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # mac postgres
  export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
fi


# ==================================
# beyond here be auto-added configs
# ==================================

