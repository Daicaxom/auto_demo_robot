*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    uuid

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
    
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    
    Run Keyword If    ${HEADLESS}    Call Method    ${options}    add_argument    --headless
    
    # Generate unique user data directory using UUID instead of timestamp
    ${uuid}=    Evaluate    str(uuid.uuid4())    uuid
    ${user_data_dir}=    Set Variable    /tmp/chrome_profile_${uuid}
    Call Method    ${options}    add_argument    --user-data-dir=${user_data_dir}
    
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    
    # Add these arguments to improve stability in CI environment
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size=1920,1080
    
    ${capabilities}=    Call Method    ${options}    to_capabilities
    
    Run Keyword If    '${REMOTE_URL}' != '${EMPTY}'    
    ...    Open Browser    
    ...    about:blank    
    ...    browser=${BROWSER}    
    ...    remote_url=${REMOTE_URL}    
    ...    desired_capabilities=${capabilities}
    ...    ELSE    
    ...    Create Webdriver    Chrome    options=${options}