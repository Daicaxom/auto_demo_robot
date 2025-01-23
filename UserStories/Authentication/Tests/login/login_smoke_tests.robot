*** Settings ***
Documentation     Smoke tests for login functionality
Resource          ../../Resources/TestFlows/LoginFlow.robot
Resource          ../../../Common/Resources/common_keywords.robot

Suite Setup       Setup Test Suite
Test Setup       Setup Test Case
Test Teardown    Cleanup Test Case
Suite Teardown    Cleanup Test Suite

*** Test Cases ***
Valid User Can Login Successfully
    [Documentation]    Verify that a valid user can login successfully
    [Tags]    smoke    login    positive
    Given User Is On Login Page
    When User Logs In With Valid Credentials    ${ADMIN_USER}
    Then User Should Be Logged In Successfully

Invalid Password Should Show Error
    [Documentation]    Verify that invalid password shows error message
    [Tags]    smoke    login    negative
    Given User Is On Login Page
    When User Attempts Login    ${TEST_USER}[username]    ${INVALID_PASSWORD}
    Then Error Message Should Be Displayed    ${INVALID_CREDENTIALS_MESSAGE}

*** Keywords ***
Setup Test Suite
    Load Test Data
    Connect To Test Database

Setup Test Case
    Setup Browser Session    ${BASE_URL}

Cleanup Test Case
    Run Keyword If Test Failed    Take Screenshot On Failure
    Cleanup Browser Session

Cleanup Test Suite
    Disconnect From Database 