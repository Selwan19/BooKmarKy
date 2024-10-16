import requests
from bs4 import BeautifulSoup
import time

# Function to fetch the HTML of the page
def fetch_html(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.text
    else:
        print(f"Failed to fetch page: {response.status_code}")
        return None

# Function to scrape bookmarks from Pinboard
def scrape_pinboard_bookmarks(username, page_limit=5):
    base_url = f"https://pinboard.in/u:{username}"
    bookmarks = []
    
    for page_num in range(1, page_limit + 1):
        print(f"Scraping page {page_num} of {page_limit}...")
        url = f"{base_url}/?page={page_num}"
        html = fetch_html(url)
        
        if not html:
            break
        
        soup = BeautifulSoup(html, 'html.parser')
        # Find all the bookmark items on the page
        bookmark_items = soup.find_all('div', class_='bookmark')
        
        for item in bookmark_items:
            title_tag = item.find('a', class_='bookmark_title')
            url_tag = item.find('a', class_='bookmark_title')
            tags_tag = item.find('a', class_='tags')
            timestamp_tag = item.find('span', class_='bookmark_time')
            
            title = title_tag.text if title_tag else "No Title"
            url = url_tag['href'] if url_tag else "No URL"
            tags = tags_tag.text if tags_tag else "No Tags"
            timestamp = timestamp_tag.text if timestamp_tag else "No Timestamp"
            
            bookmarks.append({
                'title': title,
                'url': url,
                'tags': tags,
                'timestamp': timestamp
            })
        
        # Pause briefly to avoid overwhelming the server
        time.sleep(2)
    
    return bookmarks

# Function to save bookmarks to a CSV file
import csv
def save_bookmarks_to_csv(bookmarks, filename='bookmarks.csv'):
    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.DictWriter(file, fieldnames=['title', 'url', 'tags', 'timestamp'])
        writer.writeheader()
        writer.writerows(bookmarks)
    print(f"Bookmarks saved to {filename}")

# Run the scraper
if __name__ == "__main__":
    username = 'dindit'  # Replace with the specific username or use 'public' for general
    bookmarks = scrape_pinboard_bookmarks(username, page_limit=5)
    save_bookmarks_to_csv(bookmarks)
