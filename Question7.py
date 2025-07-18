import time
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

def create_session(retries=5, backoff=0.5, status_list=(408, 500, 502, 503, 504)):
    session = requests.Session()
    retry = Retry(
        total=retries,
        backoff_factor=backoff,
        status_forcelist=status_list,
        allowed_methods=["GET", "POST"]
    )
    adapter = HTTPAdapter(max_retries=retry)
    return session

def api_call(url, session=None, timeout=(5, 10)):
    if session is None:
        session = create_session()

    try:
        start_time = time.time()
        response = session.get(url, timeout=timeout)
        response.raise_for_status()

        elapsed = time.time() - start_time
        print(f"Success: {url} - {response.status_code}")
        return response.text

    except requests.exceptions.ConnectTimeout as e:
        print(f"Connect timeout: {url} - {e}")
    except requests.exceptions.ReadTimeout as e:
        print(f"Read timeout: {url} - {e}")
    except requests.exceptions.Timeout as e:
        print(f"General timeout: {url} - {e}")
    except requests.exceptions.HTTPError as e:
        print(f"HTTP error: {url} - {e}")
    except requests.exceptions.RequestException as e:
        print(f"Request failed: {url} - {e}")

    return None

if __name__ == "__main__":
    
    session = create_session()
    test_url = input("Enter your API endpoint url: ")
    result = api_call(test_url, session=session)
