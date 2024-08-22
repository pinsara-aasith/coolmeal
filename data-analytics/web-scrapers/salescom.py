import requests
import csv
import re
from bs4 import BeautifulSoup
import os
from datetime import date


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

def get_title(html_content):
    soup = BeautifulSoup(html_content, "html.parser")
    title = soup.find("h2", class_="title-detail").text
    return title

def checkTitleIsvalid(title):
    if(title == ""):
        return False
    else:
        return True



def get_price(html_content):
    # Parse the HTML content
    soup = BeautifulSoup(html_content, "html.parser")

    # Find the <div> element with the specified class
    price_div = soup.find("div", class_="product-price primary-color float-left")

    # Find the span with the class 'current-price text-brand'
    price_span = price_div.find("span", class_="current-price text-brand")

    # Extract the price text, combining nested spans
    price_text = price_span.text.strip().replace("\n", "")

    return price_text


def get_selected_weight(html_content):
    try:
        # Parse the HTML content
        soup = BeautifulSoup(html_content, "html.parser")

        # Find the <select> element by its ID
        select_element = soup.find("select", {"id": "select_models"})
        if select_element is None:
            raise ValueError("Select element not found")

        # Find all <option> tags within the <select> element
        options = select_element.find_all("option")

        # Count the number of <option> tags
        option_count = len(options)
        selected_weight = ""

        if option_count == 1:
            title = get_title(html_content)
            if not title:
                raise ValueError("Title not found in HTML content")

            # Regular expression to match weight with units
            pattern = re.compile(r"(\d+\s?(g|kg|l|ml))", re.IGNORECASE)
            matches = pattern.findall(title)
            if matches:
                selected_weight = matches[0][0]
            else:
                raise ValueError("No weight found in title")

        else:
            # Find the selected <option> within the <select> element
            selected_option = select_element.find("option", selected=True)
            if selected_option is None:
                raise ValueError("No selected option found in select element")

            # Get the text of the selected option
            selected_weight = selected_option.text

        return selected_weight
    
    except ValueError as ve:
        print(f"Value error: {ve}")
    except Exception as e:
        print(f"An error occurred: {e}")

    return ""

with open("../datasets/ingredient_prices/salescom.lk.csv", mode="w", newline="") as file:
    # create csv file ---- 
    writer = csv.writer(file)
    header = [
        "title",
        "weight",
        "price",
    ]
    writer.writerow(header)
    for i in range(1,1000):
        url = f"https://salescom.lk/product-details?type=1&id={i}"
        html_content = fetch_html(url)
        title = get_title(html_content)
        is_valid = checkTitleIsvalid(title)
        if(is_valid):
            weight = get_selected_weight(html_content)
            # weight = get_selected_weight(html_content)
            price = get_price(html_content)
            print(f"i : {i} -------- title : {title} ------ weight : {weight} ----------  price : {price}")
            # Write data into a csv file --
            try:
                details = {
                "title": title,
                "weight": weight,
                "price": price,
                }
                writer.writerow([details[h] for h in header])
            except Exception as e:
                print(f"Error writing to CSV: {e}")
                continue
    print("Operation completed successfully.")
            


            
            

