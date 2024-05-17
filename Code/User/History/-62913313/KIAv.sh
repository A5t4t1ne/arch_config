#!/bin/bash

# first argument is the key
input=$1

# check if input is empty
if [[ -z $input ]]; then
    exit 1
fi

echo input: $input


calc_result() {
    local input=$1
    local result=0

    for ((i=0; i<${#input}; i++)); do
        char=${input:$i:1}
        ascii=$(printf '%d' "'$char")
        result=$((result + ascii))
    done

    result=$((result * 12345 % 67890))

    if ((result % 5 == 0)); then
        echo "triggered" > condition.txt
    fi

    echo $result
}


calc_result2() {
    local input=$1
    local result=0

    for ((i=0; i<${#input}; i++)); do
        char=${input:$i:1}
        ascii=$(printf '%d' "'$char")
        result=$((result * ascii))
    done

    result=$((result * 54321 % 98765))

    echo $result
}

decrypt_string() {
    local input=$1
    local decrypted_string=""

    for ((i=0; i<${#input}; i++)); do
        char=${input:$i:1}
        ascii=$(printf '%d' "'$char")
        decrypted_ascii=$((ascii ^ 42))
        decrypted_string+=$(printf \\$(printf '%03o' $decrypted_ascii))
    done

    echo $decrypted_string
}


encrypted_string="VXpKT2JGb3pTa1pPUkZaaFQwTXhUMVF4UWtaWU1scHpZVVpXVEZOck5YWmhXRlpvWTNwclBRPT0="
result=$(calc_result "$input")
additional_result=$(calc_result2 "$result")
decrypted_string=$(decrypt_string "$encrypted_string")

if [[ ${#decrypted_string} == 10 && $(cat condition.txt) == "triggered" ]]; then
    echo "Decrypted string: $decrypted_string"
else
    echo "Wrong input"
fi

# Clean up
rm -f condition.txt