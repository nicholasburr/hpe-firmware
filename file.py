#!/usr/bin/env python3

import requests
import re
from datetime import datetime

# URL to check
url = "https://downloads.linux.hpe.com/SDR/repo/spp-gen10/"

# Fetch the page content
response = requests.get(url)
response.raise_for_status()

# Extract all href entries to inspect what we are working with
all_entries = re.findall(r'href=\"([^\"]+/)\"', response.text)

# Initialize variables to track the latest valid directory
latest_dir = None
latest_date = None

# Loop through the entries and find the latest valid directory
for directory in all_entries:
    # Check if the directory matches the required format
    if re.match(r'^\d{4}\.\d{2}\.\d{2}(\.\d{2,3})?/$', directory):
        date_part = directory[:10]
        try:
            # Validate the date part (YYYY.MM.DD)
            date = datetime.strptime(date_part, "%Y.%m.%d")
            # Ensure valid month and day
            if 1 <= date.month <= 12 and 1 <= date.day <= 31:
                # If this is the first valid directory or the current one is later than the last found, update
                if latest_date is None or date > latest_date:
                    latest_date = date
                    latest_dir = directory
        except ValueError:
            continue  # Skip invalid date formats

if latest_dir:
    print(f"Latest valid directory: {url}{latest_dir}")
else:
    print("No valid directories found.")