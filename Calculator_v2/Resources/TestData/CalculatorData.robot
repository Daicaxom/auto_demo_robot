

*** Settings ***
Library    ${CURDIR}/calculator_data_generator.py
Library    Collections
Library    BuiltIn



*** Keywords ***
Generate Basic Operation Data
    [Arguments]    ${min_val}=1    ${max_val}=100    ${use_decimal}=${FALSE}
    ${data}=    Generate Numbers    ${min_val}    ${max_val}    ${use_decimal}
    RETURN   ${data}
