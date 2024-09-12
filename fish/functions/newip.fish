function newip
    sudo nmcli connection down $argv[1] && sudo nmcli connection up $argv[1]
end

