*** Settings ***
Library    SeleniumLibrary
Library    ../../Scripts/setup_test_env.py
Library    String

*** Variables ***
${BROWSER}        chrome
${URL}           https://www.calculator.net/
${HEADLESS}      ${TRUE}
${TIMEOUT}       20s
${RETRY}         0.5s

# Locators
${DISPLAY_LOCATOR}    id=calculated-display
${CLEAR_BTN}         id=buttonallclear
${NUMBER_BTN}        id=button{number}
${PLUS_BTN}         id=buttonplus
${MULTIPLY_BTN}     id=buttonmultiply
${EQUALS_BTN}       id=buttonequals
${MEMORY_PLUS_BTN}  id=buttonmemoryplus
${MEMORY_RECALL_BTN}  id=buttonmemoryrecall

*** Keywords ***
Setup Calculator Test Environment
    ${options}=    setup_test_env.Get Chrome Options    ${HEADLESS}
    Set Selenium Timeout    ${TIMEOUT}
    Set Selenium Speed     ${RETRY}
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Set Window Size    1920    1080
    Wait Until Element Is Visible    ${DISPLAY_LOCATOR}    ${TIMEOUT}

Initialize Calculator Session
    Go To    ${URL}
    Wait Until Element Is Visible    ${DISPLAY_LOCATOR}    ${TIMEOUT}
    Clear Display

Clear Display
    Wait Until Element Is Visible    ${CLEAR_BTN}    ${TIMEOUT}
    Click Element    ${CLEAR_BTN}
    Wait Until Element Contains    ${DISPLAY_LOCATOR}    0    ${TIMEOUT}

Input Number
    [Arguments]    ${number}
    # Handle single digits
    ${digits}=    Convert To String    ${number}
    FOR    ${digit}    IN    @{digits}
        ${formatted_digit}=    Set Variable If    '${digit}' == '0'    00    ${digit}
        ${btn_locator}=    Replace String    ${NUMBER_BTN}    {number}    ${formatted_digit}
        Wait Until Element Is Visible    ${btn_locator}    ${TIMEOUT}
        Click Element    ${btn_locator}
    END

Click Plus
    Wait Until Element Is Visible    ${PLUS_BTN}    ${TIMEOUT}
    Click Element    ${PLUS_BTN}

Click Multiply
    Wait Until Element Is Visible    ${MULTIPLY_BTN}    ${TIMEOUT}
    Click Element    ${MULTIPLY_BTN}

Click Equals
    Wait Until Element Is Visible    ${EQUALS_BTN}    ${TIMEOUT}
    Click Element    ${EQUALS_BTN}

Get Display Value
    ${value}=    Get Text    ${DISPLAY_LOCATOR}
    [Return]    ${value}

Verify Display Shows
    [Arguments]    ${expected}
    Wait Until Element Contains    ${DISPLAY_LOCATOR}    ${expected}    ${TIMEOUT}

Click Memory Plus
    Wait Until Element Is Visible    ${MEMORY_PLUS_BTN}    ${TIMEOUT}
    Click Element    ${MEMORY_PLUS_BTN}

Click Memory Recall
    Wait Until Element Is Visible    ${MEMORY_RECALL_BTN}    ${TIMEOUT}
    Click Element    ${MEMORY_RECALL_BTN}

Cleanup Calculator Session
    Run Keyword If Test Failed    Capture Page Screenshot
    Clear Display

Cleanup Calculator Test Environment
    Close All Browsers 