import requests
from bs4 import BeautifulSoup
import time
import csv

# Function to fetch the HTML of the page
def fetch_html(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.text
    else:
        print(f"Failed to fetch page: {response.status_code}")
        return None

# Function to scrape bookmarks from Pinboard with dynamic pagination
def scrape_pinboard_bookmarks(username, max_pages):
    base_url = f"https://pinboard.in/u:{username}/?page=1"
    bookmarks = []
    page_num = 1

    try:
        while page_num <= max_pages:
            print(f"Scraping page {page_num}...")
            url = f"https://pinboard.in/u:{username}/?page={page_num}"
            html = fetch_html(url)
            
            if not html:
                break
            
            soup = BeautifulSoup(html, 'html.parser')
            bookmark_items = soup.find_all('div', class_='bookmark')
            
            if not bookmark_items:
                print(f"No bookmarks found on page {page_num}. Ending scraping.")
                break
            
            for item in bookmark_items:
                
                title_tag = item.find('a', class_='bookmark_title')
                title = title_tag.text.strip() if title_tag else "No Title"
                url = title_tag['href'] if title_tag else "No URL"
                
               
                timestamp_tag = item.find('a', class_='when')
                timestamp = timestamp_tag['title'] if timestamp_tag else "No Timestamp"
                
                bookmarks.append({
                    'username': username,  
                    'title': title,
                    'url': url,
                    'timestamp': timestamp
                })
            
            
            next_page_link = soup.find('a', string='next')
            if next_page_link:
                page_num += 1  
                time.sleep(2)  
            else:
                print(f"Reached the end of available pages at page {page_num}.")
                break
    except KeyboardInterrupt:
        print("\nScraping interrupted by user. Saving the bookmarks to CSV file.")
        save_bookmarks_to_csv(bookmarks, username)
        print("Bookmarks saved. Exiting the program.")
        exit()

    return bookmarks

# Function to save bookmarks to a CSV file
def save_bookmarks_to_csv(bookmarks, username):
    filename = f"{username}_bookmarks.csv"
    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.DictWriter(file, fieldnames=['username', 'title', 'url', 'timestamp'])
        writer.writeheader()
        writer.writerows(bookmarks)
    print(f"Bookmarks saved to {filename}")

# Main function to run the scraper
def main():
    while True:
        username = input("Enter the Pinboard username (or 'public' for general): ")
        max_pages = int(input("Enter the number of pages you want to scrape: "))
        
        bookmarks = scrape_pinboard_bookmarks(username, max_pages)
        save_bookmarks_to_csv(bookmarks, username)

        
        again = input("Do you want to scrape another user? (y/n): ")
        if again.lower() != 'y':
            print("Exiting the program.")
            break

# Run the scraper
if __name__ == "__main__":
    main()
