import requests
r = requests.patch('<REST_URL>.json?auth=<SECURITY_TOKEN_FROM_FIREBASE>', json={"needmusic": "no"})
r.status_code
r.json()

