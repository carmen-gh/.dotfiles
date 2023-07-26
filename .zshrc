# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc. Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block; everything else may go below. if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" fi


export ZSH="$HOME/.oh-my-zsh"
export JAVA_HOME=$(/usr/libexec/java_home -v 17.0)
export BAT_THEME="OneHalfDark"
export QEMU_AUDIO_DRV=none # disable audio backend for all android emulators
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp:$PATH
export PATH=$HOME/.local/bin:$PATH

source "$HOME/.cargo/env" # add rust cargo

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"


# Plugins -------------------------------------------------------------
plugins=(git colored-man-pages gradle vi-mode)

source $ZSH/oh-my-zsh.sh

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
   export EDITOR='nvim'
 fi

# ALIAS ----------------------------------------------------------------- 
alias zshconfig="lvim ~/.zshrc"
alias vimconfig="lvim ~/.dotfiles/lvim/config.lua"
alias gitconfig="lvim ~/.gitconfig"
alias vim='lvim' 
alias avim="NVIM_APPNAME=AstroNvim nvim"
alias lg='lazygit'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color=auto '
alias rm='trash'
alias rmdir='rm -rf'
alias gw="./gradlew"
alias trim="awk '{\$1=\$1};1'"
alias ...="cd ../.."
alias ls='exa --oneline --icons'
alias ll='exa --long --icons'
alias la='exa --long --icons --all'
alias adb='~/Library/Android/sdk/platform-tools/adb'
alias adb-kill-emulator='adb -s emulator-5554 emu kill'
alias adb-restart='adb kill-server; adb start-server'
# For a full list of active aliases, run `alias`.
function take {
  mkdir -p $1
  cd $1
}

# Starship Prompt ------------------------------------------------------------
eval "$(starship init zsh)"
