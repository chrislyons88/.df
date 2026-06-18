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
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export BAT_THEME="gruvbox-dark"
export K9S_SKIN="gruvbox-dark"

# add anything that shouldn't be in the repo to ~/.secrets
[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"

# ============================
# global tool evals & sources
# ============================
eval "$(zoxide init zsh)" # zoxide init
# source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
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
alias ll="eza --icons --git --group-directories-first -alh"
alias et="eza --icons --git --group-directories-first -a --tree --git-ignore"
alias etl="eza --icons --git --group-directories-first -alh --tree --git-ignore"

# quick edit config files
alias rc="nvim ~/.zshrc && source ~/.zshrc"
alias fr="source ~/.zshrc && clear"
alias gc="nvim ~/.config/ghostty/config"
alias sshc="nvim ~/.ssh/config"

# git aliases
alias gs="git status"
alias gl="git log --pretty=format:\"%C(auto)%h %C(green)%ad %C(auto)%d %C(blue)%an %C(reset)%s\" --date=human"
alias ga="git add"
alias gcm="git commit -m"
alias gd="git diff"
alias gc="git checkout"

# neovim
alias v="nvim"
alias vc="nvim ~/.local/share/nvim/lazy/base46/lua/base46/themes/gruvbox.lua"

function fdd() { find . -name "*$1*" | grep --color=always "$1" }

# fzf
alias ff="fzf --preview 'bat --color=always --style=numbers,changes,header {}' | xargs nvim"
alias fff="fzf --style full --preview 'bat --color=always --style=numbers,changes,header {}' \
  --bind 'focus:transform-header:file --brief {}' | xargs nvim"
function fww() {
  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  local INITIAL_QUERY="${*:-}"
  fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --bind "alt-enter:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --prompt '1. ripgrep> ' \
    --delimiter : \
    --preview 'bat --color=always {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    --bind 'enter:become(vim {1} +{2})'
}
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

  # mise
  eval "$(mise activate zsh)"
fi

# ensure emacs bindings are used in tmux
bindkey -e

# ============================================
# zsh autosuggestions & syntax highlighting
# (installed via brew; guarded for non-mac envs)
# autosuggestions must be sourced BEFORE syntax
# highlighting, which must be sourced LAST.
# ============================================
for _zsh_share in /opt/homebrew/share /usr/share /home/linuxbrew/.linuxbrew/share /data/data/com.termux/files/usr/share; do
  [[ -f "$_zsh_share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
    && source "$_zsh_share/zsh-autosuggestions/zsh-autosuggestions.zsh" && break
done
unset _zsh_share

# ==================================
# beyond here be auto-added configs
# ==================================


# zsh-syntax-highlighting MUST be sourced last (after all widgets/auto-added
# configs). If a tool appends config below this line, move this block down.
for _zsh_share in /opt/homebrew/share /usr/share /home/linuxbrew/.linuxbrew/share /data/data/com.termux/files/usr/share; do
  [[ -f "$_zsh_share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
    && source "$_zsh_share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" && break
done
unset _zsh_share

