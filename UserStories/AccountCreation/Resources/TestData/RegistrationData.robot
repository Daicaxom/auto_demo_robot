*** Variables ***
# URLs
${URL_REGISTRATION}    https://example.com/register

# Success Messages
${TEXT_REGISTRATION_SUCCESS}           Registration completed successfully
${TEXT_EMAIL_VERIFICATION_REQUIRED}    Please verify your email address

# Error Messages
${TEXT_INVALID_EMAIL}                  Please enter a valid email address
${TEXT_PASSWORD_MISMATCH}             Passwords do not match

*** Keywords ***
Generate Valid User Data
    ${user_data}=    Create Dictionary
    ...    username=test_user_${RANDOM}
    ...    email=test${RANDOM}@example.com
    ...    password=Test123!
    ...    phone=1234567890
    ...    account_type=personal
    [Return]    ${user_data}

Generate Valid Business Data
    ${user_data}=    Generate Valid User Data
    Set To Dictionary    ${user_data}
    ...    account_type=business
    ...    company=Test Company
    ...    business_phone=9876543210
    [Return]    ${user_data} 