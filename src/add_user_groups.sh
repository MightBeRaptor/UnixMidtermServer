#!/bin/bash

#Names
GROUP_NAME="developer"
USER1="alice"
USER2="bob"
USER3="charlie"

# Create Groups
if ! getent group "$GROUP_NAME" > /dev/null; then
    sudo groupadd "$GROUP_NAME"
    echo "Group '$GROUP_NAME' created."
else
    echo "Group '$GROUP_NAME' already exists."
fi

# Create User Class
create_user() {
    local USERNAME=$1
    if ! id "$USERNAME" &>/dev/null; then
        sudo useradd -m -G "$GROUP_NAME" "$USERNAME"
        echo "User '$USERNAME' created and added to '$GROUP_NAME'."
    else
        echo "User '$USERNAME' already exists."
    fi
}

# Create each user
create_user "$USER1"
create_user "$USER2"
create_user "$USER3"