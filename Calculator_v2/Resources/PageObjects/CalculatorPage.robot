*** Settings ***
Documentation     POM for the Calculator page with basic operations.
Library           SeleniumLibrary
Library           String
Library           Collections
Library           Process
Library           OperatingSystem

*** Variables ***
${BROWSER}              chrome
${URL}                  https://testpages.eviltester.com/styled/apps/calculator.html
${HEADLESS}             ${TRUE}
${TIMEOUT}              20s
${RETRY}                0.5s
${CALCULATOR_DISPLAY}   id=calculated-display
${CALCULATOR_CLEAR}     id=buttonallclear
${CALCULATOR_EQUALS}    id=buttonequals
${DEFAULT_VALUE}        ${EMPTY}

# Number buttons
&{NUMBER_BUTTONS}
...    0=button00
...    1=button01
...    2=button02
...    3=button03
...    4=button04
...    5=button05
...    6=button06
...    7=button07
...    8=button08
...    9=button09

# Operation buttons
${PLUS_BTN}             id=buttonplus
${MULTIPLY_BTN}         id=buttonmultiply
${MINUS_BTN}            id=buttonminus
${DECIMAL_BTN}          id=buttondot

# Memory buttons
${MEMORY_IN_BTN}        id=buttonmemoryin
${MEMORY_ADD_BTN}       id=buttonmemoryplus
${MEMORY_RECALL_BTN}    id=buttonmemoryrecall
${CLEAR_BTN}            id=buttonclearentry

*** Keywords ***
Setup Calculator Environment
    [Documentation]    Initialize the calculator test environment
    Log    Setting up calculator test environment    console=True
    Set Selenium Timeout    ${TIMEOUT}
    ${args}=    Create List
    ...    --headless
    ...    --no-sandbox
    ...    --disable-dev-shm-usage
    ...    --disable-gpu
    ...    --window-size=1920,1080
    ...    --remote-debugging-port=9222
    ...    --disable-extensions
    ...    --disable-setuid-sandbox
    ...    --disable-web-security
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    FOR    ${arg}    IN    @{args}
        Call Method    ${chrome_options}    add_argument    ${arg}
    END
    Create Webdriver    Chrome    options=${chrome_options}
    Set Window Size    1920    1080
    Go To    ${URL}

Cleanup Calculator Environment
    [Documentation]    Clean up the test environment
    Close All Browsers

Initialize Calculator Session
    [Documentation]    Initialize a new calculator session
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}
    Click Element    ${CALCULATOR_CLEAR}

Cleanup Calculator Session
    [Documentation]    Clean up the calculator session
    Click Element    ${CALCULATOR_CLEAR}

Wait And Click Element
    [Documentation]    Wait for element to be visible and click it
    [Arguments]    ${locator}
    Wait Until Element Is Enabled    ${locator}
    Click Element    ${locator}

Click Number
    [Documentation]    Click on the number button with value ${digit}.
    [Arguments]    ${digit}
    ${locator}=    Set Variable    xpath=//button[normalize-space(text())='${digit}']
    Wait And Click Element    ${locator}

Click Plus
    [Documentation]    Click the plus button
    Wait And Click Element    ${PLUS_BTN}

Click Multiply
    [Documentation]    Click the multiply button
    Wait And Click Element    ${MULTIPLY_BTN}

Click Minus
    [Documentation]    Click the minus button
    Wait And Click Element    ${MINUS_BTN}

Click Decimal Point
    [Documentation]    Click the decimal point button
    Wait And Click Element    ${DECIMAL_BTN}

Click Equals
    [Documentation]    Click the equals button
    Wait And Click Element    ${CALCULATOR_EQUALS}

Click All Clear
    [Documentation]    Click the all clear button
    Wait And Click Element    ${CALCULATOR_CLEAR}

Click Memory In
    [Documentation]    Click the memory in button
    Wait And Click Element    ${MEMORY_IN_BTN}

Click Memory Add
    [Documentation]    Click the memory add button
    Wait And Click Element    ${MEMORY_ADD_BTN}

Click Memory Recall
    [Documentation]    Click the memory recall button
    Wait And Click Element    ${MEMORY_RECALL_BTN}

Click Clear Entry
    [Documentation]    Click the clear entry button
    Wait And Click Element    ${CLEAR_BTN}

Get Display Value
    [Documentation]    Get the value displayed on Calculator screen
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}    ${TIMEOUT}
    ${value}=    Get Element Attribute    ${CALCULATOR_DISPLAY}    value
    ${value}=    Set Variable If    '${value}' == ''    ${DEFAULT_VALUE}    ${value}
    ${value}=    Set Variable If    '${value}' == 'undefined'    ${DEFAULT_VALUE}    ${value}
    ${value}=    Set Variable If    '${value}' == 'null'    ${DEFAULT_VALUE}    ${value}
    Log    Display value: ${value}    console=True
    RETURN    ${value}

Convert And Compare Numbers
    [Documentation]    Convert and compare two numbers
    [Arguments]    ${actual}    ${expected}
    ${actual_num}=    Run Keyword If    '${actual}' == ''    Set Variable    0
    ...    ELSE    Convert To Number    ${actual}
    ${expected_num}=    Run Keyword If    '${expected}' == ''    Set Variable    0
    ...    ELSE    Convert To Number    ${expected}
    Should Be Equal As Numbers    ${actual_num}    ${expected_num}


Wait Until Display Shows
    [Documentation]    Wait until the calculator display shows the expected value
    [Arguments]    ${expected}
    Wait Until Keyword Succeeds    5s    1s    Verify Display Value    ${expected}

    

Open Calculator
    [Documentation]    Open the browser and navigate to the Calculator page.
    Open Browser    ${URL}    ${BROWSER}

Clear Calculator
    [Documentation]    Click the clear button to reset the display to the default value.
    Wait Until Element Is Visible    ${CLEAR_BTN}    ${TIMEOUT}
    Click Element    ${CLEAR_BTN}