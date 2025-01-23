from faker import Faker
import random
from datetime import datetime

fake = Faker()

class RegistrationDataGenerator:
    def __init__(self):
        self.account_types = ['standard', 'premium', 'enterprise']
        
    def generate_valid_user_data(self, account_type=None):
        if not account_type:
            account_type = random.choice(self.account_types)
            
        return {
            'username': fake.user_name(),
            'email': fake.email(),
            'password': self._generate_secure_password(),
            'first_name': fake.first_name(),
            'last_name': fake.last_name(),
            'phone': fake.phone_number(),
            'account_type': account_type,
            'profile_picture': 'default.jpg',
            'registration_date': datetime.now().isoformat()
        }
    
    def generate_invalid_email_data(self):
        user_data = self.generate_valid_user_data()
        user_data['email'] = 'invalid.email@'
        return user_data
        
    def generate_premium_account_data(self):
        user_data = self.generate_valid_user_data('premium')
        user_data.update({
            'company': fake.company(),
            'position': fake.job(),
            'business_phone': fake.phone_number()
        })
        return user_data 