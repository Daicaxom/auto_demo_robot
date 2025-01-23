*** Settings ***
Resource    ../PageObjects/LoginPage.robot
Resource    ../../AccountCreation/Resources/TestFlows/RegistrationFlow.robot
Resource    ../TestData/static/login_messages.robot

*** Keywords ***
Login With Newly Created Account
    [Arguments]    ${user_data}
    Input Username    ${user_data}[username]
    Input Password    ${user_data}[password]
    Click Login Button
    Verify Successful Login    ${user_data}[username]

Verify Account Status Before Login
    [Arguments]    ${user_data}
    ${status}=    Get Account Status    ${user_data}[username]
    Should Be Equal    ${status}    active 