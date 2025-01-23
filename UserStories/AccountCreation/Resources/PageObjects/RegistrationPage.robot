*** Settings ***
Library    SeleniumLibrary
Resource    ../../../Common/Resources/Keywords/ElementKeyword.robot

*** Variables ***
# Input Fields
${INPUT_USERNAME}           id=username
${INPUT_PASSWORD}           id=password
${INPUT_CONFIRM_PASSWORD}   id=confirmPassword
${INPUT_EMAIL}             id=email
${INPUT_PHONE}             id=phone
${INPUT_COMPANY}           id=company
${INPUT_BUSINESS_PHONE}    id=businessPhone

# Buttons
${BUTTON_REGISTER}         id=registerBtn
${BUTTON_VERIFY_EMAIL}     id=verifyEmailBtn
${BUTTON_UPLOAD_DOC}       id=uploadDocBtn
${BUTTON_SUBMIT_PROFILE}   id=submitProfileBtn

# Messages
${MESSAGE_SUCCESS}         css=.success-message
${MESSAGE_ERROR}           css=.error-message
${MESSAGE_VERIFICATION}    css=.verification-message

# Loading States
${LOADING_SPINNER}         css=.loading-spinner

*** Keywords ***
# Basic Input Actions
Input Username Field
    [Arguments]    ${username}
    Input Text To Element    ${INPUT_USERNAME}    ${username}

Input Password Field
    [Arguments]    ${password}
    Input Text To Element    ${INPUT_PASSWORD}    ${password}

Input Confirm Password Field
    [Arguments]    ${password}
    Input Text To Element    ${INPUT_CONFIRM_PASSWORD}    ${password}

Input Email Field
    [Arguments]    ${email}
    Input Text To Element    ${INPUT_EMAIL}    ${email}

Input Phone Field
    [Arguments]    ${phone}
    Input Text To Element    ${INPUT_PHONE}    ${phone}

Input Company Field
    [Arguments]    ${company}
    Input Text To Element    ${INPUT_COMPANY}    ${company}

Input Business Phone Field
    [Arguments]    ${phone}
    Input Text To Element    ${INPUT_BUSINESS_PHONE}    ${phone}

# Button Actions
Click Register Button
    Click On Element    ${BUTTON_REGISTER}

Click Verify Email Button
    Click On Element    ${BUTTON_VERIFY_EMAIL}

Click Upload Document Button
    Click On Element    ${BUTTON_UPLOAD_DOC}

Click Submit Profile Button
    Click On Element    ${BUTTON_SUBMIT_PROFILE}

# Get Message Actions
Get Success Message
    ${message}=    Get Text From Element    ${MESSAGE_SUCCESS}
    [Return]    ${message}

Get Error Message
    ${message}=    Get Text From Element    ${MESSAGE_ERROR}
    [Return]    ${message}

Get Verification Message
    ${message}=    Get Text From Element    ${MESSAGE_VERIFICATION}
    [Return]    ${message}

# Wait Actions
Wait For Success Message
    Wait Until Element Is Visible    ${MESSAGE_SUCCESS}    ${TIMEOUT_DEFAULT}

Wait For Loading Complete
    Wait Until Element Is Not Visible    ${LOADING_SPINNER}    ${TIMEOUT_DEFAULT}

Input Registration Details
    [Arguments]    ${user_data}
    Input Username         ${user_data}[username]
    Input Email           ${user_data}[email]
    Input Password        ${user_data}[password]
    Input Confirm Password    ${user_data}[password]
    Input Phone Number    ${user_data}[phone]
    Run Keyword If    '${user_data}[account_type]' == 'business'    Input Company Details    ${user_data} 