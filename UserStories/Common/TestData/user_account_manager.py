from datetime import datetime
import json
import os

class UserAccountManager:
    def __init__(self):
        self.accounts_file = 'test_accounts.json'
        self.accounts = self._load_accounts()
    
    def save_created_account(self, user_data):
        """Save newly created account for future login tests"""
        user_data['created_at'] = datetime.now().isoformat()
        self.accounts.append(user_data)
        self._save_accounts()
        
    def get_test_account(self, account_type='standard'):
        """Get a previously created account for login tests"""
        return next((acc for acc in self.accounts 
                    if acc['account_type'] == account_type 
                    and acc['status'] == 'active'), None)
    
    def _load_accounts(self):
        if os.path.exists(self.accounts_file):
            with open(self.accounts_file, 'r') as f:
                return json.load(f)
        return []
    
    def _save_accounts(self):
        with open(self.accounts_file, 'w') as f:
            json.dump(self.accounts, f, indent=2) 