
export ZSH="$HOME/.oh-my-zsh"
export BAT_THEME="Catppuccin-frappe"
export QEMU_AUDIO_DRV=none # disable audio backend for all android emulators
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp:$PATH # add swift lsp
export PATH=$HOME/.local/bin:$PATH

source "$HOME/.cargo/env" # add rust cargo

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v 17.0)
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# flutter
export PATH="$HOME/Developer/flutter/flutter/bin:$PATH"
export ANDROID_HOME="/Users/carmen.geelhaar/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Plugins -------------------------------------------------------------
plugins=(git colored-man-pages gradle vi-mode)

source $ZSH/oh-my-zsh.sh
source /path/to/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# catppuccin colored fzf output
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"


# User configuration ***************************************************
export KEYTIMEOUT=1

# Preferred editor for local and remote sessions------------------------
#
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# ALIAS ----------------------------------------------------------------- 
alias zshconfig="vim ~/.dotfiles/.zshrc"
alias gitconfig="vim ~/.gitconfig"
alias vim='nvim' 
alias avim="NVIM_APPNAME=AstroNvim nvim"
alias lazyVim="NVIM_APPNAME=LazyVim nvim"
alias nvchad="NVIM_APPNAME=nvchad nvim"
alias lg='lazygit'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color=auto '
alias rm='trash'
alias rmdir='rm -rf'
alias gw="./gradlew"
alias trim="awk '{\$1=\$1};1'"
alias ...="cd ../.."
alias ls='eza --group-directories-first --icons'
alias ll='eza --group-directories-first --icons -lh --git'
alias la='eza --group-directories-first --icons -lh --git -a'
alias tree='eza --group-directories-first --icons -lh --git --tree --level=2'
alias adb='~/Library/Android/sdk/platform-tools/adb'
alias adb-kill-emulator='adb -s emulator-5554 emu kill'
alias adb-restart='adb kill-server; adb start-server'
alias update-gh="gh extension upgrade --all"

function video_to_gif() {
    # Based on https://gist.github.com/SheldonWangRJT/8d3f44a35c8d1386a396b9b49b43c385
    output_file="${1%.*}.gif"
    ffmpeg -i $1 -pix_fmt rgb8 -r 10 -s 540x1140 $output_file && gifsicle -O3 $output_file -o $output_file
}

# on changed files run ktlint with automatic formatting
function ktcleanup {
  git diff --name-only --cached --relative | grep '\.kt[s"]\?$' | xargs ktlint --relative --format
}

# For a full list of active aliases, run `alias`.
function take {
  mkdir -p $1
  cd $1
}

# Starship Prompt ------------------------------------------------------------
eval "$(starship init zsh)"

# Startup Zoxide ------------------------------------------------------------
eval "$(zoxide init zsh)"

