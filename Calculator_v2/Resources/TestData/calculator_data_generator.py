import random

def generate_numbers(min_val=1, max_val=100, use_decimal=False):
    """Generate three random numbers and their expected results"""
    min_val = float(min_val) if use_decimal else int(min_val)
    max_val = float(max_val) if use_decimal else int(max_val)
    
    if use_decimal:
        num1 = round(random.uniform(min_val, max_val), 2)
        num2 = round(random.uniform(min_val, max_val), 2)
        num3 = round(random.uniform(min_val, max_val), 2)
    else:
        num1 = random.randint(min_val, max_val)
        num2 = random.randint(min_val, max_val)
        num3 = random.randint(min_val, max_val)
    
    return {
        'num1': str(num1),
        'num2': str(num2),
        'num3': str(num3),
        'expected_addition': str(num1 + num2),
        'expected_multiplication': str(num1 * num2),
        'expected_result': str(num1 + num2 - num3)
    }

