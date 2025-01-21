export ZSH="$HOME/.oh-my-zsh"
. "$HOME/.asdf/asdf.sh"

path=(
	'/home/linuxbrew/.linuxbrew/bin'
	'/usr/local/texlive/2024/bin/x86_64-linux/'
	'/home/dave/.local/share/bob/nvim-bin' 
	'/usr/lib/jvm/default/bin/'
	'~/.local/bin/'
   	'/usr/local/go/bin'
	'/var/lib/snapd/snap/bin'
	'/home/dave/.asdf/installs/rust/1.83.0/bin'
	$path 
)
export PATH
# export JAVA_HOME=$(asdf where java)
# export PATH=$JAVA_HOME/bin:$PATH
export VISUAL=nvim
export EDITOR="$VISUAL"


fastfetch -c $HOME/.config/fastfetch/config-v2.jsonc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Add deno completions to search path
# if [[ ":$FPATH:" != *":/home/dave/.zsh/completions:"* ]]; then export FPATH="/home/dave/.zsh/completions:$FPATH"; fi


ZSH_THEME=""

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


alias lt='ls -a -R --level=1'
alias gits='git status'
alias pping='ping -c 4 8.8.8.8'
alias ..='cd ..'

cd() {
  builtin cd "$@" && /bin/ls -a --color
}


alias cp='cp -i '
alias mv='mv -i '
alias rm='trash'
alias mkdir='mkdir -p '
alias ps='ps -auxf'
alias ping='ping -c 4'
alias less='less -R'
alias cls='clear '
alias apt='sudo apt '
alias svi='sudo vi '
alias n='nvim'


alias rmd='/bin/rm  --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias ls='ls -a --color=auto'
alias lx='ls -lXBh'               	# sort by extension
alias lk='ls -lSrh'               	# sort by size
alias lc='ls -ltcrh'              	# sort by change time
alias lu='ls -lturh'              	# sort by access time
alias lr='ls -lRh'                	# recursive ls
alias lt='ls -ltrh'               	# sort by date
alias lm='ls -alh |more'          	# pipe through 'more'
alias lw='ls -xAh'                	# wide listing format
alias labc='ls -lap'                # alphabetical sort
alias lf="ls -l | egrep -v '^d'"  	# files only
alias ldir="ls -l | egrep '^d'"   	# directories only
alias ll='ls -lah'					# long listing format
alias lla='ls -Al'                  # List and Hidden Files
alias las='ls -A'                 	# Hidden Files
alias lls='ls -l'                 	# List

alias p="ps -A | grep "

alias kssh='kitty +kitten ssh '

alias cat=bat


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
	rsync -ah --progress "${1}" "${2}"
}

gitd() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

#######################################################
# SOME MORE STUFF
#######################################################
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Color for manpages in less. Makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# init some plugins
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# . "/home/dave/.deno/env"
# Initialize zsh completions (added by deno install script)
# autoload -Uz compinit
# compinit


bindkey \^U backward-kill-line # Ctrl+U should only delete to the left of the cursor


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# source ~/powerlevel10k/powerlevel10k.zsh-theme
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export LANGUAGE=en_US

eval "$(starship init zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-as-monitor \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
#
# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
# [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# source "${ZINIT_HOME}/zinit.zsh"#
