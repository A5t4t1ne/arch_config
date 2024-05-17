#!/bin/bash

users=(Groot Drax Rocket Gamora Starlord EGO)
passwds=(
    pneumonoultramicroscopicsilicovolcanoconiosis # Groot
    I_4m_7h3_gr34t3st_0f_7h3m_4ll # Drax 
    1_4m_7h3_b357_p1l07 # Rocket
    1_4m_4_n0n-d4nc3r_0k? # Gamora
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

usermod -aG sudo EGO

groupadd --users Rocket,Gamora mother_n_pet
chown Rocket:mother_n_pet /home/Rocket
chown Gamora:mother_n_pet /home/Gamora
echo "Group mother_n_pet created, assigned and dirs configured"