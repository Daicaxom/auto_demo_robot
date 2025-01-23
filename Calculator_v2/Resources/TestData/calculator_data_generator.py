import random

class CalculatorDataGenerator:
    def generate_numbers(self, min_val=1, max_val=100, use_decimal=False):
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

    def generate_memory_operations(self, min_val=1, max_val=100, use_decimal=False):
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

def generate_numbers(generator, min_val=None, max_val=None, use_decimal=False):
    """Helper function to generate numbers"""
    return generator.generate_numbers(min_val, max_val, use_decimal)

def generate_memory_operations(generator, min_val=None, max_val=None, use_decimal=False):
    """Helper function to generate memory operations"""
    return generator.generate_memory_operations(min_val, max_val, use_decimal) 