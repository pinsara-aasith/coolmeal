import requests
import csv
import re
from bs4 import BeautifulSoup
import os
from datetime import date

# Get today's date as a string
today = f"{date.today()}"


# Function to fetch HTML content from a URL
def fetch_html(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.text
        else:
            print(f"Failed to retrieve HTML. Status code: {response.status_code}")
            return None
    except requests.RequestException as e:
        print(f"Error fetching HTML: {e}")
        return None


# Function to scrape URLs containing "sri-lanka" from the HTML content
def scrape_urls(html_content):
    urls = []
    if html_content:
        soup = BeautifulSoup(html_content, "html.parser")
        for link in soup.find_all("a", href=True):
            if "sri-lanka" in link["href"]:
                urls.append(link["href"])
    return urls


# Function to scrape price information from the HTML content of a specific URL
def scrape_price(html_content):
    if html_content:
        soup = BeautifulSoup(html_content, "html.parser")
        title = (
            soup.select_one(".entry-title")
            .get_text()
            .replace("Sri Lanka", "")
            .replace("Prices", "")
            .strip()
        )
        market = "Colombo City"
        unit = "KG"
        price = 0
        commodity = title
        priceflag = "actual"
        pricetype = "Retail"
        currency = "LKR"

        print(f"{title} :")
        print(f"\tfetching prices for {title} from selinawamucii.com...")

        for paragraph in soup.find_all("p"):
            scraped_content = paragraph.get_text().lower()

            if "retail" in scraped_content and "lkr" in scraped_content:
                pattern_kg = re.compile(r"lkr\s*([0-9|/.|/,]*)")
                prices = pattern_kg.findall(scraped_content)
                lower_price = float(prices[0].replace(",", ""))
                upper_price = float(prices[1].replace(",", ""))

                price = round((lower_price + upper_price) / 2, 2)
                print(
                    f"\tprice for {title} ranges from LKR {lower_price} to LKR {upper_price}, median price = LKR {price}"
                )

                return {
                    "commodity": commodity,
                    "market": market,
                    "unit": unit,
                    "priceflag": priceflag,
                    "pricetype": pricetype,
                    "currency": currency,
                    "lower_price": lower_price,
                    "upper_price": upper_price,
                    "price": price,
                    "scraped_content": scraped_content,
                }


if __name__ == "__main__":
    url = "https://www.selinawamucii.com/insights/prices/sri-lanka"
    html_content = fetch_html(url)
    failed_urls = []

    if html_content:
        scraped_urls = scrape_urls(html_content)
        scraped_urls.sort()
        print(f'Ingredients found from selinawamucii.com : ${len(scraped_urls)}')
        with open("datasets/ingredient_prices/selinawamucii.com.csv", mode="w", newline="") as file:
            writer = csv.writer(file)
            header = [
                "commodity",
                "market",
                "unit",
                "priceflag",
                "pricetype",
                "currency",
                "lower_price",
                "upper_price",
                "price",
                "scraped_content",
            ]
            writer.writerow(header)

            for scraped_url in scraped_urls:
                try:
                    html_for_ingredient = fetch_html(scraped_url)
                    details = scrape_price(html_for_ingredient)
                    writer.writerow([details[h] for h in header])
                except Exception as e:
                    print(e)
                    failed_urls.append(scraped_url)
                    print(f"Failed to get the prices for {scraped_url}")

        print(f"Failed urls: {len(failed_urls)}")
        for u in failed_urls:
            print(u)
