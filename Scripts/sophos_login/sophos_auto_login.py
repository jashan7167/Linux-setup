import requests
import time
import sys

# Configuration
LOGIN_URL = "http://172.16.73.12:8090/login.xml"  # Correct endpoint

def sophos_login(username, password):
    """Logs into Sophos using form-urlencoded data."""
    payload = {
        "mode": "191",  # 191 for login
        "username": username,  # Dynamic username
        "password": password,  # Dynamic password
        "a": str(int(time.time() * 1000)),  # Current timestamp in milliseconds
        "producttype": "0"  # Adjust if required
    }

    try:
        # Send data as form-urlencoded
        headers = {"Content-Type": "application/x-www-form-urlencoded"}
        response = requests.post(LOGIN_URL, data=payload, headers=headers)

        # Debugging response
        print(f"Status Code: {response.status_code}")
        print("Response Body:", response.text)

        if response.status_code == 200 and "success" in response.text.lower():
            print("Successfully logged into Sophos!")
        else:
            print("Login failed. Verify credentials and response.")
    except Exception as e:
        print(f"Error during login: {e}")

if __name__ == "__main__":
    # Ensure that the script is run with the correct number of arguments
    if len(sys.argv) != 3:
        print("Usage: python sophos_auto_login.py <username> <password>")
        sys.exit(1)
    
    username = sys.argv[1]
    password = sys.argv[2]
    
    print(f"Attempting to log into Sophos with username: {username}...")
    sophos_login(username, password)

