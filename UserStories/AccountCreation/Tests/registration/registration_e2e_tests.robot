*** Settings ***
Documentation     End-to-end registration scenarios using Gherkin syntax
Resource          ../../Resources/TestFlows/RegistrationFlow.robot
Test Setup        Start E2E Test
Test Teardown     End E2E Test

*** Test Cases ***
Scenario: Complete Registration Process
    [Documentation]    Verify the complete registration process from start to finish
    [Tags]    e2e    registration    smoke
    Given User Is On Registration Page
    And User Has Valid Registration Data
    When User Submits Registration Form
    Then Registration Should Be Successful
    And Email Verification Should Be Required
    When User Completes Email Verification
    And User Sets Up Account Profile
    Then Account Should Be Created Successfully

Scenario: Registration With Premium Account
    [Documentation]    Verify registration process for premium account type
    [Tags]    e2e    registration    premium
    Given User Is On Registration Page
    And User Has Premium Account Data
    When User Submits Registration Form
    Then Registration Should Be Successful
    When User Completes Email Verification
    And User Sets Up Premium Profile
    Then Premium Account Should Be Created Successfully

*** Keywords ***
Start E2E Test
    Set Selenium Speed    ${SELENIUM_SPEED}
    Set Selenium Timeout    ${SELENIUM_TIMEOUT}
    Connect To Test Database

End E2E Test
    Disconnect From Database
    Capture Page Screenshot
    Close All Browsers 