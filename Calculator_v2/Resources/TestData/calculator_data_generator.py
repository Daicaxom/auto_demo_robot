import random

def generate_numbers(min_val=1, max_val=100, use_decimal=False):
    """Generate two random numbers and their expected results"""
    min_val = float(min_val) if use_decimal else int(min_val)
    max_val = float(max_val) if use_decimal else int(max_val)
    
    if use_decimal:
        num1 = round(random.uniform(min_val, max_val), 2)
        num2 = round(random.uniform(min_val, max_val), 2)
    else:
        num1 = random.randint(min_val, max_val)
        num2 = random.randint(min_val, max_val)
    
    return {
        'num1': str(num1),
        'num2': str(num2),
        'expected_addition': str(num1 + num2),
        'expected_multiplication': str(num1 * num2)
    }

def generate_memory_operations(min_val=1, max_val=100, use_decimal=False):
    """Generate test data for memory operations"""
    min_val = float(min_val) if use_decimal else int(min_val)
    max_val = float(max_val) if use_decimal else int(max_val)
    
    if use_decimal:
        initial = round(random.uniform(min_val, max_val), 2)
        memory_add = round(random.uniform(min_val, max_val), 2)
        memory_subtract = round(random.uniform(min_val, max_val), 2)
    else:
        initial = random.randint(min_val, max_val)
        memory_add = random.randint(min_val, max_val)
        memory_subtract = random.randint(min_val, max_val)
    
    return {
        'initial': str(initial),
        'memory_add': str(memory_add),
        'memory_subtract': str(memory_subtract),
        'expected_result': str(initial + memory_add - memory_subtract)
    } 