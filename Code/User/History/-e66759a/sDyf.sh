#!/bin/bash

users=(Groot Drax Rocket Gamora Starlord EGO)
passwds=(
    pneumonoultramicroscopicsilicovolcanoconiosis # Groot
    I_4m_7h3_gr34t3st_0f_7h3m_4ll # Drax
    1_4m_7h3_b357_p1l07 # Rocket
    1_4m_4_n0n-d4nc3r_0k? # Gamora
    Y0u_m1gh7_kn0w_m3_45_Starlord # Star-Lord
    7h3_un1v3rs3_n33d5_t0_b3_m3 # EGO
)
home_rights=(
    750 # Groot
    750 # Drax
    750 # Rocket
    750 # Gamora
    750 # Starlord
    750 # EGO
)

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

groupadd --users Starlord,EGO celestials
echo "Group celestials created and Starlord and EGO added to it"

chown root:celestials /home/Celestials
chmod 750 /home/Celestials
chown root:root /home
echo "Ownership changed for EGO and /home"

usermod -aG sudo EGO

groupadd couple
usermdo -aG couple Starlord
usermod -aG couple Gamora
mkdir -p /etc/system/couple
chown Starlord:couple /etc/system/couple
chmod 770 /etc/system/couple
echo "#!/bin/bash\necho You're a dancer" > /etc/system/couple/random.sh
chmod 4770 /etc/system/couple/random.sh
chown Starlord:couple /etc/system/couple/random.sh

mkdir -p /var/run/docker
chown root:docker /var/run/docker
chmod 770 /var/run/docker