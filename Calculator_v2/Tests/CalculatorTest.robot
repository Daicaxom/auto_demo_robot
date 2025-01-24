*** Settings ***
Documentation     Test suite for calculator functionality using BDD approach
Resource          ../Resources/PageObjects/CalculatorPage.robot
Resource          ../Resources/TestFlows/CalculatorFlow.robot
Resource          ../Resources/TestData/CalculatorData.robot
Library           ../../Scripts/chrome_manager.py

Suite Setup       Initialize Chrome Environment
Suite Teardown    Cleanup Chrome Environment
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
    Log    Starting test: Basic Integer Addition    console=True
    Given Calculator is ready for input
    When User generates test data for basic operation    min=1    max=100    use_decimals=${FALSE}
    And User performs addition operation with generated numbers
    Then Result should match expected addition value

User can perform basic integer multiplication
    [Documentation]    Verify that calculator can perform basic multiplication with integers
    [Tags]    smoke    multiplication    integer
    Log    Starting test: Basic Integer Multiplication    console=True
    Given Calculator is ready for input
    When User generates test data for basic operation    min=1    max=100    use_decimals=${FALSE}
    And User performs multiplication operation with generated numbers
    Then Result should match expected multiplication value

User can perform decimal addition
    [Documentation]    Verify that calculator can perform addition with decimal numbers
    [Tags]    smoke    addition    decimal
    Log    Starting test: Decimal Addition    console=True
    Given Calculator is ready for input
    When User generates test data for basic operation    min=1    max=100    use_decimals=${TRUE}
    And User performs addition operation with generated numbers
    Then Result should match expected addition value

User can perform decimal multiplication
    [Documentation]    Verify that calculator can perform multiplication with decimal numbers
    [Tags]    smoke    multiplication    decimal
    Log    Starting test: Decimal Multiplication    console=True
    Given Calculator is ready for input
    When User generates test data for basic operation    min=1    max=100    use_decimals=${TRUE}
    And User performs multiplication operation with generated numbers
    Then Result should match expected multiplication value

User can perform memory operations sequence
    [Documentation]    Verify that calculator can perform a sequence of memory operations
    [Tags]    smoke    memory
    Log    Starting test: Memory Operations Sequence    console=True
    Given Calculator is ready for input
    When User generates test data for memory operations    min=1    max=100    use_decimals=${FALSE}
    And User performs memory operation sequence with generated data
    Then Result should match expected memory operation value

*** Keywords ***
# Given Steps
Calculator is ready for input
    Log    Ensuring calculator is ready for input    console=True
    Clear Display
    Verify Display Shows    ${DEFAULT_VALUE}

# When Steps
User generates test data for basic operation
    [Arguments]    ${min}    ${max}    ${use_decimals}
    Log    Generating test data for basic operation (min=${min}, max=${max}, decimals=${use_decimals})    console=True
    ${test_data}=    Generate Basic Operation Data    ${min}    ${max}    ${use_decimals}
    Set Test Variable    ${TEST_DATA}    ${test_data}
    Log    Generated test data: ${test_data}    console=True

User generates test data for memory operations
    [Arguments]    ${min}    ${max}    ${use_decimals}
    Log    Generating test data for memory operations (min=${min}, max=${max}, decimals=${use_decimals})    console=True
    ${test_data}=    Generate Memory Test Data    ${min}    ${max}    ${use_decimals}
    Set Test Variable    ${TEST_DATA}    ${test_data}
    Log    Generated test data: ${test_data}    console=True

User performs addition operation with generated numbers
    Log    Performing addition operation with numbers: ${TEST_DATA}[num1] + ${TEST_DATA}[num2]    console=True
    ${result}=    Perform Addition Operation    ${TEST_DATA}[num1]    ${TEST_DATA}[num2]
    Set Test Variable    ${ACTUAL_RESULT}    ${result}
    Log    Addition operation result: ${result}    console=True

User performs multiplication operation with generated numbers
    Log    Performing multiplication operation with numbers: ${TEST_DATA}[num1] * ${TEST_DATA}[num2]    console=True
    ${result}=    Perform Multiplication Operation    ${TEST_DATA}[num1]    ${TEST_DATA}[num2]
    Set Test Variable    ${ACTUAL_RESULT}    ${result}
    Log    Multiplication operation result: ${result}    console=True

User performs memory operation sequence with generated data
    Log    Performing memory operation sequence    console=True
    ${result}=    Perform Memory Operation Sequence    ${TEST_DATA}
    Set Test Variable    ${ACTUAL_RESULT}    ${result}
    Log    Memory operation sequence result: ${result}    console=True

# Then Steps
Result should match expected addition value
    Log    Verifying addition result    console=True
    Verify Calculation Result    ${TEST_DATA}[expected_addition]

Result should match expected multiplication value
    Log    Verifying multiplication result    console=True
    Verify Calculation Result    ${TEST_DATA}[expected_multiplication]

Result should match expected memory operation value
    Log    Verifying memory operation result    console=True
    Verify Calculation Result    ${TEST_DATA}[expected_result]

# Setup and Teardown
Initialize Chrome Environment
    ${chrome_manager}=    ChromeManager
    Set Suite Variable    ${CHROME_MANAGER}    ${chrome_manager}
    ${driver}=    Call Method    ${CHROME_MANAGER}    create_driver    headless=${HEADLESS}
    Set Suite Variable    ${DRIVER}    ${driver}

Cleanup Chrome Environment
    Call Method    ${CHROME_MANAGER}    cleanup

Initialize Calculator Session
    Go To    ${CALCULATOR_URL}
    Maximize Browser Window
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}

Cleanup Calculator Session
    Run Keyword If Test Failed    Capture Page Screenshot
    Go To    about:blank

Log Test Execution Results
    Run Keyword If Test Failed    Capture Page Screenshot
    Log    Test Case: ${TEST_NAME}    console=True
    Log    Test Status: ${TEST_STATUS}    console=True 