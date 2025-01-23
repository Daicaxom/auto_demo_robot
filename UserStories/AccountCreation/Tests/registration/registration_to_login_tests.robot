*** Settings ***
Documentation     End-to-end tests from registration to login
Resource          ../../Resources/TestFlows/RegistrationFlow.robot
Resource          ../../../Login/Resources/TestFlows/LoginFlow.robot
Resource          ../../../Common/Resources/common_keywords.robot
Test Teardown     Cleanup Test Case

*** Test Cases ***
User Can Register And Login Successfully
    [Documentation]    Verify that a newly registered user can login successfully
    [Tags]    e2e    registration    login    smoke
    # Registration Phase
    ${user_data}=    Generate Test User Data
    Register New User    ${user_data}
    Verify Account Creation Success    ${user_data}
    
    # Login Phase
    Logout If Logged In
    Login With Newly Created Account    ${user_data}
    Verify Successful Login    ${user_data}[username] 