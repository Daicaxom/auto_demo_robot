*** Settings ***
Library    SeleniumLibrary
Library    ../../Scripts/setup_test_env.py

*** Variables ***
${BROWSER}        chrome
${URL}           https://www.calculator.net/
${HEADLESS}      ${TRUE}
${TIMEOUT}       10s
${REMOTE_URL}    ${EMPTY}

*** Keywords ***
Setup Calculator Test Environment
    ${options}=    setup_test_env.Get Chrome Options    ${HEADLESS}
    Set Selenium Timeout    ${TIMEOUT}
    
    Run Keyword If    '${REMOTE_URL}' != '${EMPTY}'    
    ...    Open Browser    
    ...    ${URL}    
    ...    browser=${BROWSER}    
    ...    remote_url=${REMOTE_URL}    
    ...    options=${options}
    ...    ELSE    
    ...    Create Webdriver    Chrome    options=${options}
    
    Set Window Size    1920    1080
    Go To    ${URL}

Cleanup Calculator Test Environment
    Close All Browsers

Initialize Calculator Session
    Wait Until Page Contains Element    id=sciOutPut
    Clear Display

Cleanup Calculator Session
    Run Keyword If Test Failed    Capture Page Screenshot
    Clear Display 