*** Settings ***
Library    SeleniumLibrary
Variables  ../TestData/static/messages.robot

*** Variables ***
${LOGIN_USERNAME_FIELD}    id=username
${LOGIN_PASSWORD_FIELD}    id=password
${LOGIN_BUTTON}           id=loginBtn
${ERROR_MESSAGE}         css=.error-message

*** Keywords ***
Input Username
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_FIELD}
    Input Text    ${LOGIN_USERNAME_FIELD}    ${username}

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    ${LOGIN_PASSWORD_FIELD}
    Input Password    ${LOGIN_PASSWORD_FIELD}    ${password}

Click Login Button
    Wait Until Element Is Enabled    ${LOGIN_BUTTON}
    Click Element    ${LOGIN_BUTTON}

Get Error Message
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    ${message}=    Get Text    ${ERROR_MESSAGE}
    [Return]    ${message}

Verify Error Message
    [Arguments]    ${expected_message}
    ${actual_message}=    Get Error Message
    Should Be Equal    ${actual_message}    ${expected_message} 