*** Settings ***
Resource    ../PageObjects/CalculatorPage.robot
Library    String
Library    SeleniumLibrary
Library    BuiltIn

*** Keywords ***
# Single Action Methods
Enter Number
    [Arguments]    ${number}
    [Documentation]    Enters a number into the calculator
    Log    Entering number: ${number}    console=True
    ${digits}=    Convert To String    ${number}
    @{chars}=    Split String To Characters    ${digits}
    FOR    ${char}    IN    @{chars}
        Run Keyword If    '${char}' == '.'    Click Decimal Point
        ...    ELSE    Click Number    ${char}
    END
    Sleep    0.5s

# Verification Keywords
Verify Result
    [Arguments]    ${expected_value}
    [Documentation]    Verifies the calculator display shows expected value
    Log    Verifying result: ${expected_value}    console=True
    ${actual_value}=    Get Display Value
    ${actual_value}=    Set Variable If    '${actual_value}' == ''    0    ${actual_value}
    ${expected_value}=    Set Variable If    '${expected_value}' == ''    0    ${expected_value}
    Should Be Equal As Strings    ${actual_value}    ${expected_value}
    Log    Verification passed: ${actual_value} equals ${expected_value}    console=True

# Complex Operation Flows
Perform Basic Operation
    [Arguments]    ${first_number}    ${second_number}    ${operation}
    [Documentation]    Performs basic arithmetic operation and returns result
    Log    Performing ${operation}: ${first_number} ${operation} ${second_number}    console=True
    Enter Number    ${first_number}
    Run Keyword If    '${operation}' == 'addition'    Click Plus
    ...    ELSE IF    '${operation}' == 'multiplication'    Click Multiply
    Enter Number    ${second_number}
    Click Equals
    Sleep    0.5s
    ${result}=    Get Display Value
    Log    ${operation} result: ${result}    console=True
    RETURN    ${result}

Perform Addition Operation
    [Arguments]    ${first_number}    ${second_number}
    [Documentation]    Performs addition operation and returns result
    ${result}=    Perform Basic Operation    ${first_number}    ${second_number}    addition
    RETURN    ${result}

Perform Multiplication Operation
    [Arguments]    ${first_number}    ${second_number}
    [Documentation]    Performs multiplication operation and returns result
    ${result}=    Perform Basic Operation    ${first_number}    ${second_number}    multiplication
    RETURN    ${result}

Perform Memory Operation Sequence
    [Arguments]    ${data}
    [Documentation]    Performs a sequence of memory operations
    Log    Starting memory operation sequence    console=True
    Log    Initial value: ${data}[num1]    console=True
    Enter Number    ${data}[num1]
    Log    Storing in memory    console=True
    Click Memory In
    Clear Calculator
    Log    Memory add value: ${data}[num2]    console=True
    Enter Number    ${data}[num2]
    Log    Adding to memory    console=True
    Click Memory Add
    Clear Calculator
    Log    Recalling memory    console=True
    Click Memory Recall
    Log    Clicking minus operator    console=True
    Click Minus
    Log    Memory subtract value: ${data}[num3]    console=True
    Enter Number    ${data}[num3]
    Log    Clicking equals button    console=True
    Click Equals
    Sleep    0.5s
    ${result}=    Get Display Value
    Log    Memory operation result: ${result}    console=True
    RETURN    ${result}

# Test Setup/Teardown Keywords
Initialize Calculator Session
    [Documentation]    Opens calculator and prepares for testing
    Log    Initializing calculator session    console=True
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}
    Log    Calculator session initialized successfully    console=True

Cleanup Calculator Session
    [Documentation]    Closes calculator session
    Log    Cleaning up calculator session    console=True
    Close Browser

Reset Calculator State
    [Documentation]    Resets calculator to initial state
    Clear Calculator
    Verify Result    ${DEFAULT_VALUE}

Execute Operation Flow
    [Arguments]    ${operation}    ${min}    ${max}    ${use_decimals}
    [Documentation]    Generates test data and executes the specified operation flow
    ${test_data}=    Generate Basic Operation Data    ${min}    ${max}    ${use_decimals}
    Set Test Variable    ${TEST_DATA}    ${test_data}
    ${result}=    Perform Basic Operation    ${TEST_DATA}[num1]    ${TEST_DATA}[num2]    ${operation}
    Set Test Variable    ${ACTUAL_RESULT}    ${result}

Execute Memory Operation Flow
    ${result}=    Perform Memory Operation Sequence    ${TEST_DATA}
    Set Test Variable    ${ACTUAL_RESULT}    ${result}

Verify Operation Result
    [Arguments]    ${operation}
    ${expected}=    Set Variable If    
    ...    '${operation}' == 'addition'    ${TEST_DATA}[expected_addition]
    ...    '${operation}' == 'multiplication'    ${TEST_DATA}[expected_multiplication]
    Verify Result    ${expected}

Verify Memory Operation Result
    Verify Result    ${TEST_DATA}[expected_result]
