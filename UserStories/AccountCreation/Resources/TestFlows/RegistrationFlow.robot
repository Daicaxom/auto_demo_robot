*** Settings ***
Resource    ../PageObjects/RegistrationPage.robot
Resource    ../TestData/RegistrationData.robot

*** Keywords ***
# Registration Action Flows
Register New Personal Account
    [Arguments]    ${user_data}
    Fill Personal Registration Form    ${user_data}
    Submit Registration Form
    Verify Registration Success
    Complete Email Verification Flow    ${user_data}[email]

Register New Business Account
    [Arguments]    ${user_data}
    Fill Business Registration Form    ${user_data}
    Submit Registration Form
    Verify Registration Success
    Complete Email Verification Flow    ${user_data}[email]
    Setup Business Profile    ${user_data}

# Form Filling Actions
Fill Personal Registration Form
    [Arguments]    ${user_data}
    Input Basic User Information    ${user_data}
    Input Personal Details    ${user_data}

Fill Business Registration Form
    [Arguments]    ${user_data}
    Input Basic User Information    ${user_data}
    Input Business Details    ${user_data}

Input Basic User Information
    [Arguments]    ${user_data}
    Input Username Field    ${user_data}[username]
    Input Password Field    ${user_data}[password]
    Input Confirm Password Field    ${user_data}[password]
    Input Email Field    ${user_data}[email]

Input Personal Details
    [Arguments]    ${user_data}
    Input Phone Field    ${user_data}[phone]

Input Business Details
    [Arguments]    ${user_data}
    Input Phone Field    ${user_data}[phone]
    Input Company Field    ${user_data}[company]
    Input Business Phone Field    ${user_data}[business_phone]

# Form Submission Actions
Submit Registration Form
    Click Register Button
    Wait For Loading Complete
    Wait For Success Message

# Email Verification Flow
Complete Email Verification Flow
    [Arguments]    ${email}
    ${code}=    Get Verification Code    ${email}
    Input Verification Code    ${code}
    Submit Verification
    Verify Email Verification Success

Submit Verification
    Click Verify Email Button
    Wait For Loading Complete
    Wait For Success Message

# Business Profile Setup
Setup Business Profile
    [Arguments]    ${user_data}
    Upload Business Documents    ${user_data}
    Fill Business Profile    ${user_data}
    Submit Business Profile
    Verify Business Profile Created

# Verification Keywords
Verify Registration Success
    ${message}=    Get Success Message
    Should Be Equal    ${message}    ${TEXT_REGISTRATION_SUCCESS}

Verify Email Verification Success
    ${message}=    Get Verification Message
    Should Be Equal    ${message}    ${TEXT_VERIFICATION_SUCCESS}

Verify Business Profile Created
    ${message}=    Get Success Message
    Should Be Equal    ${message}    ${TEXT_BUSINESS_PROFILE_SUCCESS}

# Error Handling
Verify Registration Error
    [Arguments]    ${expected_error}
    ${actual_error}=    Get Error Message
    Should Be Equal    ${actual_error}    ${expected_error}

# Test Setup Keywords
Setup Registration Test Data
    [Arguments]    ${account_type}=personal
    IF    '${account_type}' == 'personal'
        ${user_data}=    Generate Valid User Data
    ELSE
        ${user_data}=    Generate Valid Business Data
    END
    Set Test Variable    ${USER_DATA}    ${user_data}
    [Return]    ${user_data}

Handle Registration Timeout
    [Arguments]    ${timeout}=${TIMEOUT_DEFAULT}
    Wait Until Keyword Succeeds    ${timeout}    2s    Check Registration Status