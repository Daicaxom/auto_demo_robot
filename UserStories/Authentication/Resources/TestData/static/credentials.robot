*** Variables ***
# Valid Credentials
&{ADMIN_USER}    username=admin    password=admin123    role=admin
&{TEST_USER}     username=testuser password=test123     role=user

# Invalid Credentials
&{LOCKED_USER}    username=locked    password=pass123    status=locked
&{INACTIVE_USER}  username=inactive  password=pass123    status=inactive

# Test Data
${INVALID_PASSWORD}    wrongpass123
${INVALID_USERNAME}    nonexistentuser 