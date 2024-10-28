if status is-interactive
    # Commands to run in interactive sessions can go here
end


set -U fish_user_paths /home/dave/.local/share/bob/nvim-bin $fish_user_paths
set -gx EDITOR nvim

starship init fish | source
zoxide init fish | source
fzf --fish | source

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,build
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

rvm default
