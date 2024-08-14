#!/usr/bin/python3
"""A script that queries the Reddit API to find the number
of subscribers for a given subreddit"""
import requests


def number_of_subscribers(subreddit):
    # Defining the URL for the API request
    url = f"https://www.reddit.com/r/{subreddit}/about.json"

    # Setting a customer user-agent to avoid request blocking
    headers = {'User-Agent': 'Mozilla/5.0'}

    # Making the API request
    response = requests.get(url, headers=headers, allow_redirects=False)

    # Checking if the response is valid
    if response.status_code == 200:
        # Parsing the JSON response
        data = response.json()
        # Extracting the number of subscribers
        return data.get("data", {}).get("subscribers", 0)
    else:
        # Returning 0 for an invalid subreddit
        return 0
