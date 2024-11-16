export ZSH="$HOME/.oh-my-zsh"
path=(
	'/home/linuxbrew/.linuxbrew/bin'
	'/usr/local/texlive/2024/bin/x86_64-linux/'
	'/home/dave/.local/share/bob/nvim-bin' 
	'/usr/lib/jvm/default/bin/'
	'/home/dave/.local/share/gem/ruby/3.3.0/bin'
	'~/.local/bin/'
	$path 
)
export PATH

fastfetch -c $HOME/.config/fastfetch/config-v2.jsonc


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/dave/.zsh/completions:"* ]]; then export FPATH="/home/dave/.zsh/completions:$FPATH"; fi


ZSH_THEME="steeef"

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
	fzf
)

source $ZSH/oh-my-zsh.sh


alias ll='ls -la'
alias lt='ls -a -R --level=1'
alias gits='git status'
alias pping='ping -c 4 8.8.8.8'
alias ..='cd ..'
cd () {
    if builtin cd "$@" 2>/tmp/cd_err; then
        ls
    else
		echo "cd: $(tail -c +9 /tmp/cd_err)" >&2
    fi
}



alias cp='cp -i '
alias mv='mv -i '
alias rm='gio trash '
alias mkdir='mkdir -p '
alias ps='ps auxf'
alias ping='ping -c 4'
alias less='less -R'
alias cls='clear '
alias apt='sudo apt '
alias svi='sudo vi '

alias rmd='/bin/rm  --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias la='ls -Alh'                # show hidden files
alias ls='ls -a --color '		  # add colors and file type extensions
alias lx='ls -lXBh'               # sort by extension
alias lk='ls -lSrh'               # sort by size
alias lc='ls -ltcrh'              # sort by change time
alias lu='ls -lturh'              # sort by access time
alias lr='ls -lRh'                # recursive ls
alias lt='ls -ltrh'               # sort by date
alias lm='ls -alh |more'          # pipe through 'more'
alias lw='ls -xAh'                # wide listing format
alias ll='ls -Fls'                # long listing format
alias labc='ls -lap'              # alphabetical sort
alias lf="ls -l | egrep -v '^d'"  # files only
alias ldir="ls -l | egrep '^d'"   # directories only
alias lla='ls -Al'                # List and Hidden Files
alias las='ls -A'                 # Hidden Files
alias lls='ls -l'                 # List

alias p="ps aux | grep "

alias kssh='kitty +kitten ssh '

alias cat=batcat

#######################################################
# SPECIAL FUNCTIONS
#######################################################
# Extracts any archive(s) (if unp isn't installed)
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}


# Copy file with a progress bar
cpp() {
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}



HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# init some plugins
eval "$(zoxide init zsh)"
source /etc/profile.d/rvm.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# . "/home/dave/.deno/env"
# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit


bindkey \^U backward-kill-line # Ctrl+U should only delete to the left of the cursor

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
