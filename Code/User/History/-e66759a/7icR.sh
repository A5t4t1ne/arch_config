#!/bin/bash

users=(Groot Drax Rocket Gamora Starlord EGO)
passwds=(pneumonoultramicroscopicsilicovolcanoconiosis drax rocket gamora starlord ego)
home_rights=(755 755 750 750 750 750)

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
    chmod "${home_rights[$i]}" /home/"${users[$i]}"
    echo "${users[$i]}:${passwds[$i]}" | chpasswd
done

groupadd celestials
usermod -aG celestials Starlord
usermod -aG celestials EGO
echo "Group celestials created and Starlord and EGO added to it"

mkdir -p /home/Celestials
chown EGO:celestials /home/Celestials
chown root:root /home
echo "Ownership changed for EGO and /home"