
source ~/.local/share/omarchy/default/bash/rc

export ANDROID_HOME=/opt/android-sdk/
export ANDROID_SDK_ROOT=/opt/android-sdk/
export ANDROID_AVD_HOME=~/.android/avd

export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$HOME/.oh-my-zsh"

export FLUTTER="$HOME/Developer/.flutter/flutter/bin"
export PATH="$FLUTTER:$PATH"
export CHROME_EXECUTABLE="chromium"

export SSH_AUTH_SOCK=/home/carmen/.bitwarden-ssh-agent.sock

# export BAT_THEME="Catppuccin-frappe"
export QEMU_AUDIO_DRV=none # disable audio backend for all android emulators
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Plugins -------------------------------------------------------------
plugins=(git colored-man-pages gradle vi-mode asdf)


# catppuccin colored fzf output
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"


# User configuration ***************************************************
export KEYTIMEOUT=1

# Preferred editor for local and remote sessions------------------------
export EDITOR='vim'

# ALIAS -----------------------------------------------------------------
alias zshconfig="vim ~/.dotfiles/.zshrc"
alias gitconfig="vim ~/.gitconfig"
alias vim='nvim'
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
alias adb='$ANDROID_HOME/platform-tools/adb'
alias adb-kill-emulator='adb -s emulator-5554 emu kill'
alias adb-restart='adb kill-server; adb start-server'
alias update-gh="gh extension upgrade --all"
# ... more alias in ~/.oh-my-zsh/custom/

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function video_to_gif() {
    # Based on https://gist.github.com/SheldonWangRJT/8d3f44a35c8d1386a396b9b49b43c385
    output_file="${1%.*}.gif"
    ffmpeg -i $1 -pix_fmt rgb8 -r 10 -s 540x1140 $output_file && gifsicle -O3 $output_file -o $output_file
}

# on changed files run ktlint with automatic formatting
function ktcleanup {
  git diff --name-only --cached --relative | grep '\.kt[s"]\?$' | xargs ktlint --relative --format
}

function take {
  mkdir -p $1
  cd $1
}

# Starship Prompt ------------------------------------------------------------
eval "$(starship init zsh)"

# Startup Zoxide ------------------------------------------------------------
eval "$(zoxide init zsh)"

# activate mise -------------------------------------------------------------
eval "$(mise activate zsh)"

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/fzf"
plug "zap-zsh/vim"

# Load and initialise completion system
autoload -Uz compinit
compinit
