import requests
import time

# Configuration
LOGOUT_URL = "http://172.16.73.12:8090/logout.xml"  # Correct endpoint for logout
USERNAME = "211562"  # Replace with your username
PASSWORD = "jashanJOT1"  # Replace with your password

def sophos_logout():
    """Logs out of the Sophos system."""
    payload = {
        "mode": "193",  # '193' for logout
        "username": USERNAME,
        "a": str(int(time.time() * 1000)),# Current timestamp in milliseconds
        "producttype": "0"
    }

    try:
        # Send data as form-urlencoded
        headers = {"Content-Type": "application/x-www-form-urlencoded"}
        response = requests.post(LOGOUT_URL, data=payload, headers=headers)

        # Debugging response
        print(f"Status Code: {response.status_code}")
        print("Response Body:", response.text)

        if response.status_code == 200:
            print("Successfully logged out of Sophos!")
        else:
            print("Logout failed. Verify credentials and response.")
    except Exception as e:
        print(f"Error during logout: {e}")

if __name__ == "__main__":
    print("Attempting to log out of Sophos...")
    sophos_logout()

