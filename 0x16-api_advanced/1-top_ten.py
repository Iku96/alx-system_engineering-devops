import requests


def top_ten(subreddit):
    # Define the URL for the API request
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    # Set a custom User-Agent
    headers = {'User-Agent': 'Mozilla/5.0'}
    # Make the API request
    response = requests.get(url, headers=headers, allow_redirects=False)
    # Check if the response is valid
    if response.status_code == 200:
        # Parse the JSON response
        data = response.json()
        # Extract and print the titles of the first 10 hot posts
        posts = data.get("data", {}).get("children", [])
        for post in posts:
            print(post.get("data", {}).get("title"))
    else:
        # Print None for an invalid subreddit
        print(None)
