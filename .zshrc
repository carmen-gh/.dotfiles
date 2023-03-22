# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc. Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block; everything else may go below. if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" fi


export ZSH="$HOME/.oh-my-zsh"
export JAVA_HOME=$(/usr/libexec/java_home -v 11.0)
export BAT_THEME="OneHalfDark"
export QEMU_AUDIO_DRV=none # disable audio backend for all android emulators

export PATH=/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp:$PATH


source "$HOME/.cargo/env" # add rust cargo

# THEME ------------------------------------------------------------
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins -------------------------------------------------------------
plugins=(git colored-man-pages gradle vi-mode)

source $ZSH/oh-my-zsh.sh


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
#
alias zshconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.dotfiles/nvim/init.lua"
alias gitconfig="nvim ~/.gitconfig"
alias adb='~/Library/Android/sdk/platform-tools/adb'
alias vim='nvim' 
alias lg='lazygit'
alias mv='mv -i'
alias ls='exa --oneline --icons'
alias ll='exa --long --icons'
alias la='exa --long --icons --all'
alias adb-kill-emulator='adb -s emulator-5554 emu kill'
alias adb-restart='adb kill-server; adb start-server'
# For a full list of active aliases, run `alias`.

# POWERLEVEL ------------------------------------------------------------
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/.p10k.zsh.
[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh
