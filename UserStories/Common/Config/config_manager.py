import yaml
import os
from pathlib import Path

class ConfigManager:
    def __init__(self):
        self.env = os.getenv('TEST_ENV', 'development')
        self.config_dir = Path(__file__).parent.parent.parent.parent / 'config'
        self._load_configs()

    def _load_configs(self):
        # Load public configs
        with open(self.config_dir / 'env.yaml') as f:
            self.env_config = yaml.safe_load(f)[self.env]

        # Load secrets
        secrets_file = self.config_dir / 'secrets.yaml'
        if secrets_file.exists():
            with open(secrets_file) as f:
                self.secrets = yaml.safe_load(f)[self.env]
        else:
            # Fallback to environment variables if no secrets file
            self.secrets = {
                'db': {
                    'username': os.getenv('DB_USERNAME'),
                    'password': os.getenv('DB_PASSWORD')
                }
            }

    def get_db_config(self):
        return {
            'host': self.env_config['db']['host'],
            'port': self.env_config['db']['port'],
            'database': self.env_config['db']['database'],
            'user': self.secrets['db']['username'],
            'password': self.secrets['db']['password']
        } 