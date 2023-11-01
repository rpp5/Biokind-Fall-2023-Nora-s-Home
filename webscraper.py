import re
import requests
from bs4 import BeautifulSoup
from typing import List, Optional


def get_zipcodes_from_file(file_path: str) -> List[str]:
    """Read zipcodes from a file."""
    with open(file_path, 'r') as file:
        zipcodes = [line.strip() for line in file.readlines()]
    return zipcodes


def get_state_from_zipcode(zipcode: str) -> Optional[str]:
    """Get the state corresponding to a zipcode using Zippopotam.us API."""
    url = f"http://api.zippopotam.us/us/{zipcode}"
    try:
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()
        return data['places'][0]['state']
    except (requests.RequestException, KeyError):
        print(f"Failed to fetch state for zipcode {zipcode}")
        return None


def get_income(zipcode: str, state: str) -> Optional[str]:
    """Get the income for a given zipcode and state."""
    url = f"https://www.incomebyzipcode.com/{state}/{zipcode}"
    try:
        response = requests.get(url)
        response.raise_for_status()
    except requests.RequestException as e:
        print(f"Request error for zipcode {zipcode}, state {state}: {e}")
        return None
    
    soup = BeautifulSoup(response.text, 'html.parser')

    try:
        h3_tag = soup.find('h3', string="Median Household Income")
        p_tag = h3_tag.find_next_sibling('p')
        income = re.search(r'\$\d{1,3}(,\d{3})*', p_tag.text).group()
        return income.replace('$', '').replace(',', '')
    except (AttributeError, TypeError) as e:
        print(f"HTML parsing error for zipcode {zipcode}, state {state}: {e}")
        return None


def write_to_file(zipcode: str, state: str, income: str, output_path: str):
    """Write the results to a file."""
    with open(output_path, 'a') as file:
        file.write(f"{zipcode},{state},{income}\n")


def main():
    input_path = "data/zipcode.txt"
    output_path = "data/output.csv"

    write_to_file("zipcode", "state", "income", output_path)

    zipcodes = get_zipcodes_from_file(input_path)

    for zipcode in zipcodes:
        state = get_state_from_zipcode(zipcode)
        if state:
            state = state.replace(' ', '').lower()
            income = get_income(zipcode, state)
            if income:
                print(f"The income for zipcode {zipcode} in state {state} is {income}")
                write_to_file(zipcode, state, income, output_path)
            else:
                write_to_file(zipcode, state, "not_found", output_path)
        else:
            write_to_file(zipcode, "not_found", "not_found", output_path)


if __name__ == "__main__":
    main()
