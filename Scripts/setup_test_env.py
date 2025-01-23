import os
import sys
import argparse
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager

def setup_webdrivers():
    """Download and setup WebDrivers"""
    ChromeDriverManager().install()
    GeckoDriverManager().install()

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
    main() 