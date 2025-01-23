*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    DateTime

*** Variables ***
${BROWSER}              chrome
${DEFAULT_TIMEOUT}      20s
${IMPLICIT_WAIT}        10s

*** Keywords ***
Setup Browser Session
    [Arguments]    ${url}    ${browser}=${BROWSER}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}

Cleanup Browser Session
    Close All Browsers

Take Screenshot On Failure
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Capture Page Screenshot    ${SCREENSHOTS_DIR}/${TEST_NAME}_${timestamp}.png

Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Wait Until Element Is Enabled    ${locator}
    Click Element    ${locator}

Wait And Input Text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    Wait Until Element Is Enabled    ${locator}
    Input Text    ${locator}    ${text}