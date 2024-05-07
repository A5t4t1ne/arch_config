if status is-interactive
    # Commands to run in interactive sessions can go here
end


set -U fish_user_paths /home/dave/.local/share/bob/nvim-bin $fish_user_paths

starship init fish | source
zoxide init fish | source
