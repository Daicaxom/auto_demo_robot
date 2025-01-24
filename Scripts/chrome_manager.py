import os
import psutil
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager

class ChromeManager:
    ROBOT_LIBRARY_SCOPE = 'SUITE'
    
    @classmethod
    def get_instance(cls):
        """Create and return a ChromeManager instance for Robot Framework"""
        return cls()
        
    def __init__(self):
        self.driver = None
        self.profile_dir = None
        self._setup_profile_dir()
        
    def _setup_profile_dir(self):
        """Create unique Chrome profile directory"""
        import uuid
        self.profile_dir = f"/tmp/chrome_profile_{uuid.uuid4().hex}"
        os.makedirs(self.profile_dir, exist_ok=True)
        
    def get_chrome_options(self, headless=True):
        """Configure Chrome options"""
        options = webdriver.ChromeOptions()
        if headless:
            options.add_argument('--headless=new')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')
        options.add_argument('--disable-gpu')
        options.add_argument(f'--user-data-dir={self.profile_dir}')
        options.add_argument('--disable-software-rasterizer')
        options.add_argument('--disable-extensions')
        return options
        
    def create_driver(self, headless=True):
        """Create and configure Chrome WebDriver"""
        options = self.get_chrome_options(headless)
        service = Service(ChromeDriverManager().install())
        self.driver = webdriver.Chrome(service=service, options=options)
        return self.driver
        
    def cleanup(self):
        """Clean up Chrome processes and profile directory"""
        if self.driver:
            try:
                self.driver.quit()
            except:
                pass
                
        # Kill any remaining Chrome processes
        for proc in psutil.process_iter(['pid', 'name']):
            try:
                if 'chrome' in proc.info['name'].lower():
                    proc.kill()
            except:
                pass
                
        # Remove profile directory
        if self.profile_dir and os.path.exists(self.profile_dir):
            try:
                import shutil
                shutil.rmtree(self.profile_dir)
            except:
                pass