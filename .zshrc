#######################################################
# PATH UPDATES
#######################################################
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
export VISUAL=nvim
export EDITOR="$VISUAL"
export LANGUAGE=en_US




#######################################################
# ALIASES
#######################################################
alias lt='ls -a -R --level=1'
alias gits='git status'
alias pping='ping -c 4 8.8.8.8'
alias ..='cd ..'
alias cat=bat

cd() {
  builtin cd "$@" && /bin/ls -a --color
}


alias cp='cp -i '
alias mv='mv -i '
alias rm='trash'
alias mkdir='mkdir -p '
alias ps='ps -aux'
alias ping='ping -c 4'
alias less='less -R'
alias n='nvim'

alias rmd='/bin/rm --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias ls='ls -a --color=auto'
alias lx='ls -lXBh'               	# sort by extension
alias lk='ls -lSrh'               	# sort by size
alias lt='ls -ltrh'               	# sort by date
alias lf="ls -l | grep -vE '^d'"  	# files only
alias ldir="ls -l | grep -E '^d'"  	# directories only
alias ll='ls -lah'					# long listing format

alias p="ps -aux | \grep --color=auto "

alias kssh='kitty +kitten ssh '
alias pparu='sudo pacman'




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
# SOME MORE RANDOM STUFF
#######################################################
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
FUNCNEST=100
setopt appendhistory

# Color for manpages in less. Makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'



#######################################################
# START PLUGINS AND TOOLS
#######################################################
fastfetch -c $HOME/.config/fastfetch/config-v2.jsonc

eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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


zinit light-mode for \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust


# Load zsh-autosuggestions
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Load zsh-syntax-highlighting
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting


#######################################################
# KEYBINDS
#######################################################
bindkey '^F' autosuggest-accept
bindkey '^U' backward-kill-line # Ctrl+U should only delete to the left of the cursor
bindkey '^K' kill-line
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '\e[3~' delete-char



