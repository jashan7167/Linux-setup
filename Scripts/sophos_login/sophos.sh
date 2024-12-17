#!/bin/bash

# Prompt the user to choose login or logout
echo "Choose an option:"
echo "1. Login"
echo "2. Logout"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        # Login
        echo "You chose Login"
        read -p "Enter your username: " username
        read -sp "Enter your password: " password
        echo ""  # To move to the next line after password input
        echo "Logging in with username: $username"
        # Call the login script (use your actual path to the script)
       /usr/bin/python3 /home/jsb/script/sophos_auto_login.py "$username" "$password";; 
    2)
        # Logout
        echo "You chose Logout"

        /usr/bin/python3 /home/jsb/script/sophos_auto_logout.py
        ;;
    *)
        echo "Invalid choice! Please select 1 or 2."
        ;;
esac

