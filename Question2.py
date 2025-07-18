import requests
import json

def fetch_data_from_api(url):
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        content_type = response.headers.get('content-type', '')
        if 'application/json' not in content_type:
            print(f"Warning: Expected JSON, but received Content-Type: {content_type}")
            print(f"Response content: {response.text[:200]}...")
            return None
        data = response.json()
        return data

    except requests.exceptions.HTTPError as e:
        print(f"HTTP Error: {e}")
        print(f"Response content (if available): {response.text}")
        return None
    except json.JSONDecodeError as e:
        print(f"JSON Decoding Error: {e}")
        print(f"Failed to decode JSON. Response text: {response.text[:500]}...")
        return None
    except requests.exceptions.ConnectionError as e:
        print(f"Connection Error: {e}")
        return None
    except requests.exceptions.Timeout as e:
        print(f"Timeout Error: {e}")
        return None
    except requests.exceptions.RequestException as e:
        print(f"An unexpected request error occurred: {e}")
        return None
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return None

api_url = "https://api.data.gov.sg/v1/environment/air-temperature"


data = fetch_data_from_api(api_url)

if data:
    print("Successfully fetched data:")
    print(data)
else:
    print("Failed to retrieve data.")


Reference: https://www.claudiokuenzler.com/blog/1394/how-to-handle-json-decode-error-python-script-try-except
