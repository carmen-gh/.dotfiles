
starship init fish | source
zoxide init fish | source

/usr/bin/mise activate fish | source
set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings

# Cursor styles
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

set -Ux EDITOR nvim
set -Ux VISUAL nvim
# set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"
# set -UX FZF_DEFAULT_OPTS " \
# --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
# --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
# --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

# set -Ux FZF_DEFAULT_OPTS "\
# --reverse \
# --border rounded \
# --no-info \
# --pointer='' \
# --marker=' ' \
# --ansi \
# --color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic'"

# MANPAGER
set -x MANPAGER "sh -c 'col -bx | bat -l man -p --theme 'Nord''"
set -x MANROFFOPT "-c"

# GO
set -x GOPATH $HOME/.go 
fish_add_path $HOME/.go/bin

# RUST
fish_add_path $HOME/.cargo/bin

#set -x JAVA_HOME /usr/bin/java
set -x JDK_HOME /usr/lib/jvm/jre-17-openjdk/
set -x JAVA_HOME $JDK_HOME/jre-17-openjdk

# ANDROID
set -x ANDROID_HOME $HOME/.android
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path $ANDROID_HOME/platform-tools
set -Ux QEMU_AUDIO_DRV "none" # disable audio backend for all android emulators

# Elixir
fish_add_path $HOME/.mix/escripts

fish_add_path $HOME/.local/bin/



# Abbreviations

## git
abbr gco 'git checkout'
abbr gaa 'git add -all'
abbr gcm 'git commit -m'
abbr ggpull 'git pull origin'
abbr ggpush 'git push origin'
## ls 
alias ls 'eza --group-directories-first --icons'
alias ll 'eza --group-directories-first --icons -lh --git'
alias la 'eza --group-directories-first --icons -lh --git -a'
alias tree 'eza --group-directories-first --icons -lh --git --tree --level=2'

abbr mv 'mv -i'
abbr cp 'cp -i'
abbr grep 'grep --color=auto '
abbr rmdir 'rm -rf'
abbr cat 'bat'
abbr lg lazygit
abbr adb-kill-emulator 'adb -s emulator-5554 emu kill'
abbr adb-restart 'adb kill-server; adb start-server'
abbr gw "./gradlew"
abbr ... "cd ../.."
abbr update-gh "gh extension upgrade --all"
abbr unzip "ouch decompress"
abbr zip "ouch compress"



# to change the current working directory when exiting Yazi
function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
