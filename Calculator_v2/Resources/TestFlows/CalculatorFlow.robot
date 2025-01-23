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
    Sleep    0.2s

Clear Display
    [Documentation]    Clears the calculator display
    Log    Clearing calculator display    console=True
    Click All Clear
    Verify Display Shows    0

# Operation Actions
Press Addition Operator
    [Documentation]    Clicks the addition operator
    Log    Pressing addition operator    console=True
    Click Plus

Press Multiplication Operator
    [Documentation]    Clicks the multiplication operator
    Log    Pressing multiplication operator    console=True
    Click Multiply

Press Equals
    [Documentation]    Clicks the equals button and returns result
    Log    Pressing equals button    console=True
    Click Equals
    Sleep    0.5s
    ${result}=    Get Display Value
    Log    Result obtained: ${result}    console=True
    RETURN    ${result}

# Memory Actions
Store In Memory
    [Documentation]    Stores current value in memory
    Log    Storing value in memory    console=True
    Click Memory In

Add To Memory
    [Documentation]    Adds current value to memory
    Log    Adding value to memory    console=True
    Click Memory Add

Recall Memory
    [Documentation]    Recalls value from memory
    Log    Recalling value from memory    console=True
    Click Memory Recall

# Verification Keywords
Verify Display Shows
    [Arguments]    ${expected_value}
    [Documentation]    Verifies the calculator display shows expected value
    Log    Verifying display shows: ${expected_value}    console=True
    Wait Until Display Shows    ${expected_value}

Verify Calculation Result
    [Arguments]    ${expected_result}
    [Documentation]    Verifies the calculation result matches expected value
    Log    Verifying calculation result matches: ${expected_result}    console=True
    ${actual_result}=    Get Display Value
    Should Be Equal As Numbers    ${actual_result}    ${expected_result}
    Log    Verification passed: ${actual_result} equals ${expected_result}    console=True

# Complex Operation Flows
Perform Addition Operation
    [Arguments]    ${first_number}    ${second_number}
    [Documentation]    Performs addition operation and returns result
    Log    Performing addition: ${first_number} + ${second_number}    console=True
    Enter Number    ${first_number}
    Press Addition Operator
    Enter Number    ${second_number}
    ${result}=    Press Equals
    Log    Addition result: ${result}    console=True
    RETURN    ${result}

Perform Multiplication Operation
    [Arguments]    ${first_number}    ${second_number}
    [Documentation]    Performs multiplication operation and returns result
    Log    Performing multiplication: ${first_number} * ${second_number}    console=True
    Enter Number    ${first_number}
    Press Multiplication Operator
    Enter Number    ${second_number}
    ${result}=    Press Equals
    Log    Multiplication result: ${result}    console=True
    RETURN    ${result}

Perform Memory Operation Sequence
    [Arguments]    ${data}
    [Documentation]    Performs a sequence of memory operations
    Log    Starting memory operation sequence    console=True
    Log    Initial value: ${data}[initial]    console=True
    Enter Number    ${data}[initial]
    Store In Memory
    Clear Display
    Log    Memory add value: ${data}[memory_add]    console=True
    Enter Number    ${data}[memory_add]
    Add To Memory
    Clear Display
    Recall Memory
    Click Minus
    Log    Memory subtract value: ${data}[memory_subtract]    console=True
    Enter Number    ${data}[memory_subtract]
    ${result}=    Press Equals
    Log    Memory operation result: ${result}    console=True
    RETURN    ${result}

# Test Setup/Teardown Keywords
Initialize Calculator Session
    [Documentation]    Opens calculator and prepares for testing
    Log    Initializing calculator session    console=True
    Open Browser    ${CALCULATOR_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}
    Log    Calculator session initialized successfully    console=True

Cleanup Calculator Session
    [Documentation]    Closes calculator session
    Log    Cleaning up calculator session    console=True
    Close Browser