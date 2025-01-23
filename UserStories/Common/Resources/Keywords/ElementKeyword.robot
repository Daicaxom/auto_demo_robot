*** Settings ***
Library    SeleniumLibrary
Resource   ../Locators/InputFieldLocator.robot

*** Variables ***
${TIMEOUT_DEFAULT}    20s

*** Keywords ***
Input Text To Element
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT_DEFAULT}
    Input Text    ${locator}    ${text}

Click On Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT_DEFAULT}
    Wait Until Element Is Enabled    ${locator}    ${TIMEOUT_DEFAULT}
    Click Element    ${locator}

Get Text From Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT_DEFAULT}
    ${text}=    Get Text    ${locator}
    [Return]    ${text}

Input Username
    [Arguments]    ${username}
    Input Text To Element    ${INPUT_USERNAME_FIELD}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text To Element    ${INPUT_PASSWORD_FIELD}    ${password}

Input Email
    [Arguments]    ${email}
    Input Text To Element    ${INPUT_EMAIL_FIELD}    ${email}

Click Submit Button
    Click On Element    ${BUTTON_SUBMIT} 