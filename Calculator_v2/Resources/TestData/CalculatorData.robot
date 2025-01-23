*** Settings ***
Library    ${CURDIR}/calculator_data_generator.py
Library    Collections
Library    BuiltIn

*** Variables ***
${CALCULATOR_URL}    https://testpages.eviltester.com/styled/apps/calculator.html

*** Keywords ***
Generate Basic Operation Data
    [Arguments]    ${min_val}=1    ${max_val}=100    ${use_decimal}=${FALSE}
    ${generator}=    Create Calculator Generator
    ${data}=    Generate Numbers    ${generator}    ${min_val}    ${max_val}    ${use_decimal}
    RETURN   ${data}

Generate Memory Test Data
    [Arguments]    ${min_val}=1    ${max_val}=100    ${use_decimal}=${FALSE}
    ${generator}=    Create Calculator Generator
    ${data}=    Generate Memory Operations    ${generator}    ${min_val}    ${max_val}    ${use_decimal}
    RETURN   ${data}

Create Calculator Generator
    ${generator}=    Evaluate    calculator_data_generator.CalculatorDataGenerator()
    RETURN    ${generator} 