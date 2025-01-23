*** Settings ***
Documentation     Basic registration functionality tests using Gherkin syntax
Resource          ../../Resources/TestFlows/RegistrationFlow.robot
Resource          ../../../Common/Resources/Keywords/CommonKeywords.robot
Test Setup        Start Test
Test Teardown     End Test

*** Test Cases ***
Scenario: Successful User Registration
    [Documentation]    Verify that a user can register successfully with valid data
    [Tags]    smoke    registration    positive
    Given User Is On Registration Page
    And User Has Valid Registration Data
    When User Submits Registration Form
    Then Registration Should Be Successful
    And Email Verification Should Be Required

Scenario: Registration With Invalid Email
    [Documentation]    Verify that registration fails with invalid email format
    [Tags]    registration    negative    validation
    Given User Is On Registration Page
    And User Has Invalid Email Data
    When User Submits Registration Form
    Then Registration Should Fail With Error    ${INVALID_EMAIL_ERROR}

*** Keywords ***
Start Test
    Start Browser Session    ${BASE_URL}

End Test
    Capture Screenshot On Failure
    End Browser Session 