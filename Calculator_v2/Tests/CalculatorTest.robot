*** Settings ***
Resource          ../Resources/PageObjects/CalculatorPage.robot
Resource          ../Resources/TestFlows/CalculatorFlow.robot
Resource          ../Resources/TestData/CalculatorData.robot

Suite Setup       Setup Calculator Environment
Suite Teardown    Cleanup Calculator Environment
Test Setup       Initialize Calculator Session
Test Teardown    Cleanup Calculator Session

*** Variables ***
${TIMEOUT}    10s
${HEADLESS}    ${TRUE}
${REMOTE_URL}    ${EMPTY}

*** Test Cases ***
User can perform basic integer addition
    [Documentation]    Verify that calculator can perform basic addition with integers
    [Tags]    smoke    addition    integer
    Given Calculator is ready for input
    When User performs basic operation    addition    1    100    ${FALSE}
    Then Result should match expected value    addition

User can perform basic integer multiplication
    [Documentation]    Verify that calculator can perform basic multiplication with integers
    [Tags]    smoke    multiplication    integer
    Given Calculator is ready for input
    When User performs basic operation    multiplication    1    100    ${FALSE}
    Then Result should match expected value    multiplication

User can perform decimal addition
    [Documentation]    Verify that calculator can perform addition with decimal numbers
    [Tags]    smoke    addition    decimal
    Given Calculator is ready for input
    When User performs basic operation    addition    1    100    ${TRUE}
    Then Result should match expected value    addition

User can perform decimal multiplication
    [Documentation]    Verify that calculator can perform multiplication with decimal numbers
    [Tags]    smoke    multiplication    decimal
    Given Calculator is ready for input
    When User performs basic operation    multiplication    1    100    ${TRUE}
    Then Result should match expected value    multiplication

User can perform memory operations sequence
    [Documentation]    Verify that calculator can perform a sequence of memory operations
    [Tags]    smoke    memory
    Given Calculator is ready for input
    When User performs memory operation    1    100    ${FALSE}
    Then Result should match expected memory value

*** Keywords ***
# Given Steps
Calculator is ready for input
    [Documentation]    Ensures calculator is in initial state and ready for input
    Reset Calculator State
    Verify Result    ${DEFAULT_VALUE}

# When Steps
User performs basic operation
    [Arguments]    ${operation}    ${min}    ${max}    ${use_decimals}
    Execute Operation Flow    ${operation}    ${min}    ${max}    ${use_decimals}

User performs memory operation
    [Arguments]    ${min}    ${max}    ${use_decimals}
    ${test_data}=    Generate Basic Operation Data    ${min}    ${max}    ${use_decimals}
    Set Test Variable    ${TEST_DATA}    ${test_data}
    Execute Memory Operation Flow

# Then Steps
Result should match expected value
    [Arguments]    ${operation}
    Verify Operation Result    ${operation}

Result should match expected memory value
    Verify Memory Operation Result

# Setup and Teardown
Initialize Chrome Environment
    Setup Calculator Environment

Cleanup Chrome Environment
    Close All Browsers
    Run Keyword And Ignore Error    Remove Directory    ${CHROME_TEMP_DIR}    recursive=True

Initialize Calculator Session
    Go To    ${URL}
    Maximize Browser Window
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}

Cleanup Calculator Session
    Run Keyword If Test Failed    Capture Page Screenshot
    Go To    about:blank

Log Test Execution Results
    Run Keyword If Test Failed    Capture Page Screenshot
    Log    Test Case: ${TEST_NAME}    console=True
    Log    Test Status: ${TEST_STATUS}    console=True 