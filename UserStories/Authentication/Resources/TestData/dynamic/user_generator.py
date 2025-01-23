from faker import Faker
from datetime import datetime
import random
import string

fake = Faker()

class UserGenerator:
    def __init__(self):
        self.roles = ['admin', 'user', 'manager']
        self.statuses = ['active', 'inactive', 'pending']
        
    def generate_password(self, length=12):
        characters = string.ascii_letters + string.digits + string.punctuation
        return ''.join(random.choice(characters) for i in range(length))
    
    def generate_user(self, role=None, status='active'):
        if not role:
            role = random.choice(self.roles)
            
        user = {
            'username': fake.user_name(),
            'email': fake.email(),
            'password': self.generate_password(),
            'role': role,
            'status': status,
            'first_name': fake.first_name(),
            'last_name': fake.last_name(),
            'phone': fake.phone_number(),
            'created_at': datetime.now().isoformat()
        }
        return user 