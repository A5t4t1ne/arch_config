#!/bin/bash

users=(Groot Drax Rocket Gamora Starlord EGO)
passwds=(
    pneumonoultramicroscopicsilicovolcanoconiosis # Groot
    I_4m_7h3_gr34t3st_0f_7h3m_4ll # Drax 
    I_4m_N07_4_R4c00n! # Rocket 
    gamora # Gamora
    starlord # Star-Lord
    ego # EGO
)
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

chown root:celestials /home/Celestials
chmod 750 /home/Celestials
chown root:root /home
echo "Ownership changed for EGO and /home"