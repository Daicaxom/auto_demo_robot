*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    DateTime

*** Variables ***
${DEFAULT_TIMEOUT}    20s
${SELENIUM_SPEED}     0.1s
${BROWSER}           chrome

*** Keywords ***
# Browser Management
Start Browser Session
    [Arguments]    ${url}    ${browser}=${BROWSER}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}
    Set Selenium Speed    ${SELENIUM_SPEED}

End Browser Session
    Close All Browsers

# Element Interactions
Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${locator}    ${DEFAULT_TIMEOUT}
    Click Element    ${locator}

Wait And Input Text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    Input Text    ${locator}    ${text}

Get Element Text When Ready
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    ${text}=    Get Text    ${locator}
    [Return]    ${text}

# Validation Keywords
Verify Element Text
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}=    Get Element Text When Ready    ${locator}
    Should Be Equal    ${actual_text}    ${expected_text}

Verify Element Contains Text
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}=    Get Element Text When Ready    ${locator}
    Should Contain    ${actual_text}    ${expected_text}

# Test Setup/Teardown
Capture Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot    ${SCREENSHOTS_DIR}/${TEST_NAME}_${GET_TIME()}.png

# Database Keywords
Connect To Test DB
    [Arguments]    ${db_config}
    Connect To Database Using Custom Params    ${db_config}

Disconnect From Test DB
    Disconnect From Database 