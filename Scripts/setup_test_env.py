import os
import sys
import argparse
from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service

def setup_webdrivers():
    """Download and setup WebDriver"""
    ChromeDriverManager().install()

def create_directories():
    """Create necessary directories"""
    directories = [
        'Results',
        'Screenshots',
        'Downloads',
        'Logs'
    ]
    for directory in directories:
        os.makedirs(directory, exist_ok=True)

def get_options(headless=True):
    options = Options()
    if headless:
        options.add_argument('--headless=new')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=1920,1080')
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--disable-extensions')
    options.add_argument('--disable-web-security')
    options.add_argument('--allow-running-insecure-content')
    return options

def get_webdriver(options):
    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=options)
    return driver

def main():
    parser = argparse.ArgumentParser(description='Setup test environment')
    parser.add_argument('--env', choices=['dev', 'staging', 'prod'], default='dev',
                      help='Environment to setup (default: dev)')
    
    args = parser.parse_args()
    
    print(f"Setting up test environment for: {args.env}")
    setup_webdrivers()
    create_directories()
    print("Setup completed successfully!")

if __name__ == "__main__":
    print("Chrome WebDriver setup completed successfully!") 