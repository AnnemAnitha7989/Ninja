#!/bin/bash
BASE_DIR="/home"
TEAM_DIR="team"
NINJA_DIR="ninja"
# Function to create a new team (group)
addTeam() {
    local team_name=$1
    groupadd "$team_name"
    echo "Team '$team_name' created."
}
# Function to create a new user under a team
addUser() {
    local user_name=$1
    local team_name=$2
    useradd -m -G "$team_name" "$user_name"
    echo "User '$user_name' added to team '$team_name'."    
# Set up home directory structure
    local user_home="$BASE_DIR/$user_name"
    mkdir -p "$user_home/$TEAM_DIR" "$user_home/$NINJA_DIR"    
# Set permissions for the home directory and subdirectories
    chmod 700 "$user_home"
    chmod 770 "$user_home/$TEAM_DIR"
    chmod 770 "$user_home/$NINJA_DIR"    
# Set the user's home directory permissions for team members
    for teammate in $(getent group "$team_name" | cut -d: -f4 | tr ',' ' '); do
        if [ "$teammate" != "$user_name" ]; then
            chmod 750 "$BASE_DIR/$teammate"
        fi
    done    
# Set ninja directory permissions for all ninja users
    chmod 770 "$user_home/$NINJA_DIR"
}
# Function to change a user's shell
changeShell() {
    local user_name=$1
    local new_shell=$2
    usermod -s "$new_shell" "$user_name"
    echo "Shell for user '$user_name' changed to '$new_shell'."
}
# Function to change a user's password
changePasswd() {
    local user_name=$1
    passwd "$user_name"
}
# Function to delete a user
delUser() {
    local user_name=$1
    userdel -r "$user_name"
    echo "User '$user_name' deleted."
}
# Function to delete a team
delTeam() {
    local team_name=$1
    groupdel "$team_name"
    echo "Team '$team_name' deleted."
}
# Function to list users
listUsers() {
    local type=$1
    if [ "$type" == "User" ]; then
        cut -d: -f1 /etc/passwd
    elif [ "$type" == "Team" ]; then
        cut -d: -f1 /etc/group
    fi
}
# Main Function to process commands
case "$1" in
    addTeam)
        addTeam "$2"
        ;;
    addUser)
        addUser "$2" "$3"
        ;;
    changeShell)
        changeShell "$2" "$3"
        ;;
    changePasswd)
        changePasswd "$2"
        ;;
    delUser)
        delUser "$2"
        ;;
    delTeam)
        delTeam "$2"
        ;;
    ls)
        listUsers "$2"
        ;;
    *)
        echo "Invalid command. Usage: $0 {addTeam|addUser|changeShell|changePasswd|delUser|delTeam|ls}"
        ;;
esac
