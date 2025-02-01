*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    uuid
Library    Process
Library    OperatingSystem

*** Variables ***
${BROWSER}        chrome
${URL}           https://testpages.eviltester.com/styled/apps/calculator.html
${HEADLESS}      ${TRUE}
${TIMEOUT}       20s
${RETRY}         0.5s
${CALCULATOR_DISPLAY}    id=calculated-display
${CALCULATOR_CLEAR}      id=buttonallclear
${CALCULATOR_EQUALS}     id=buttonequals
${DEFAULT_VALUE}         ${EMPTY}

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
Wait And Click Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

Click Number
    [Arguments]    ${number}
    ${button_id}=    Get From Dictionary    ${NUMBER_BUTTONS}    ${number}
    Wait And Click Element    id=${button_id}

Click Plus
    Wait And Click Element    ${PLUS_BTN}

Click Multiply
    Wait And Click Element    ${MULTIPLY_BTN}

Click Minus
    Wait And Click Element    ${MINUS_BTN}

Click Decimal Point
    Wait And Click Element    ${DECIMAL_BTN}

Click Equals
    Wait And Click Element    ${CALCULATOR_EQUALS}

Click All Clear
    Wait And Click Element    ${CALCULATOR_CLEAR}

Click Memory In
    Wait And Click Element    ${MEMORY_IN_BTN}

Click Memory Add
    Wait And Click Element    ${MEMORY_ADD_BTN}

Click Memory Recall
    Wait And Click Element    ${MEMORY_RECALL_BTN}

Click Clear Entry
    Wait And Click Element    ${CLEAR_BTN}

Get Display Value
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}
    ${value}=    Get Element Attribute    ${CALCULATOR_DISPLAY}    value
    ${value}=    Set Variable If    '${value}' == ''    ${DEFAULT_VALUE}    ${value}
    RETURN    ${value}

Convert And Compare Numbers
    [Arguments]    ${actual}    ${expected}
    ${actual_num}=    Run Keyword If    '${actual}' == ''    Set Variable    0
    ...    ELSE    Convert To Number    ${actual}
    ${expected_num}=    Run Keyword If    '${expected}' == ''    Set Variable    0
    ...    ELSE    Convert To Number    ${expected}
    Should Be Equal As Numbers    ${actual_num}    ${expected_num}

Verify Display Value
    [Arguments]    ${expected}
    ${actual}=    Get Display Value
    Convert And Compare Numbers    ${actual}    ${expected}

Wait Until Display Shows
    [Arguments]    ${expected}
    Wait Until Keyword Succeeds    5s    1s    Verify Display Value    ${expected}

Clear Display
    Wait Until Element Is Visible    ${CLEAR_BTN}    ${TIMEOUT}
    Click Element    ${CLEAR_BTN}
    Verify Display Shows    ${DEFAULT_VALUE}

# Setup and Teardown
Setup Calculator Environment
    Log    Setting up calculator test environment    console=True
    Set Selenium Timeout    ${TIMEOUT}
    
    # Create unique temp directory for this run
    ${timestamp}=    Evaluate    str(int(time.time()))    time
    ${temp_dir}=    Set Variable    /tmp/chrome_${timestamp}
    Create Directory    ${temp_dir}
    
    # Add Chrome options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Run Keyword If    ${HEADLESS}    Call Method    ${options}    add_argument    --headless=new
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size=1920,1080
    Call Method    ${options}    add_argument    --user-data-dir\=${temp_dir}
    Call Method    ${options}    add_argument    --disable-software-rasterizer
    
    # Create and configure WebDriver
    Create Webdriver    Chrome    options=${options}
    Set Window Size    1920    1080
    
    # Store temp dir for cleanup
    Set Suite Variable    ${CHROME_TEMP_DIR}    ${temp_dir}

Cleanup Calculator Environment
    Run Keyword If Test Failed    Capture Page Screenshot
    Close All Browsers
    Run Keyword If    ${CHROME_TEMP_DIR}    Remove Directory    ${CHROME_TEMP_DIR}    recursive=True

Initialize Calculator Session
    Go To    ${URL}
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}
    Click Element    ${CALCULATOR_CLEAR}

Cleanup Calculator Session
    Click Element    ${CALCULATOR_CLEAR}