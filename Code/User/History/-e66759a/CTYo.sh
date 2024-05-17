#!/bin/bash

users=(Groot Drax Rocket Gamora Starlord EGO)
passwds=(groot drax rocket gamora starlord ego)

# create users only if they don't exist in for-loop
for i in "${!users[@]}"; do
    if id "${users[$i]}" &>/dev/null; then
        echo "User ${users[$i]} already exists"
    else
        useradd -s /bin/bash "${users[$i]}"
        echo "User ${users[$i]} created"
    fi
    mkdir -p /home/"${users[$i]}"
    chown -R "${users[$i]}":"${users[$i]}" /home/"${users[$i]}"
    chmod 750 /home/"${users[$i]}"
    echo "${users[$i]}:${passwds[$i]}" | chpasswd
done

groupadd celestials
usermod -aG celestials Starlord
usermod -aG celestials EGO

chown EGO:celestials /home/EGO