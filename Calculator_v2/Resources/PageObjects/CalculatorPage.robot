*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${CALCULATOR_DISPLAY}    id=calculated-display
${CALCULATOR_CLEAR}      id=buttonallclear
${CALCULATOR_EQUALS}     id=buttonequals
${DEFAULT_VALUE}         0

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
${CLEAR_ENTRY_BTN}      id=buttonclearentry

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
    Wait And Click Element    ${CLEAR_ENTRY_BTN}

Get Display Value
    Wait Until Element Is Visible    ${CALCULATOR_DISPLAY}
    ${value}=    Get Element Attribute    ${CALCULATOR_DISPLAY}    value
    ${value}=    Set Variable If    '${value}' == ''    0    ${value}
    RETURN    ${value}

Convert And Compare Numbers
    [Arguments]    ${actual}    ${expected}
    ${actual}=    Convert To Number    ${actual}
    ${expected}=    Convert To Number    ${expected}
    Should Be Equal As Numbers    ${actual}    ${expected}

Verify Display Value
    [Arguments]    ${expected}
    ${actual}=    Get Display Value
    Convert And Compare Numbers    ${actual}    ${expected}

Wait Until Display Shows
    [Arguments]    ${expected}
    Wait Until Keyword Succeeds    5s    1s    Verify Display Value    ${expected}