
import requests

url = "https://api.data.gov.sg/v1/environment/air-temperature"
response = requests.get(url)

try:
    
    response.raise_for_status()
    data = response.json()

    
    for user in data.get("users", []):
        print(f"Name: {user['name']}, Role: {user['role']}")

except requests.exceptions.RequestException as req_err:
    print(f"Request error: {req_err}")
except ValueError as json_err:
    print(f"JSON parsing error: {json_err}")
