# Phân tầng Keyword trong Automation Framework

## 1. Core Layer (Base Keywords)
Keywords cơ bản từ thư viện và custom base keywords

### SeleniumLibrary Keywords
- `Click Element`
  - Mục đích: Click vào một element
  - Nguồn: SeleniumLibrary
  - Ví dụ: `Click Element    ${SUBMIT_BUTTON}`

- `Input Text`
  - Mục đích: Nhập text vào field
  - Nguồn: SeleniumLibrary
  - Ví dụ: `Input Text    ${USERNAME_FIELD}    john_doe`

- `Wait Until Element Is Visible`
  - Mục đích: Chờ element hiển thị
  - Nguồn: SeleniumLibrary
  - Ví dụ: `Wait Until Element Is Visible    ${LOGIN_BUTTON}    20s`

### Custom Base Keywords
- `Wait And Click Element`
  - Mục đích: Chờ và click element
  - File: CommonKeywords.robot
  - Ví dụ:
    ```robotframework
    Wait And Click Element    ${locator}
        Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
        Wait Until Element Is Enabled    ${locator}    ${DEFAULT_TIMEOUT}
        Click Element    ${locator}
    ```

## 2. POM Layer (Page Objects)
Keywords tương tác với các element trên từng page cụ thể

### LoginPage Keywords
- `Input Username`
  - Mục đích: Nhập username vào login form
  - File: LoginPage.robot
  - Ví dụ:
    ```robotframework
    Input Username    ${username}
        Wait And Input Text    ${LOGIN_USERNAME_FIELD}    ${username}
    ```

### CalculatorPage Keywords
- `Click Number`
  - Mục đích: Click số trên máy tính
  - File: CalculatorPage.robot
  - Ví dụ:
    ```robotframework
    Click Number    ${number}
        ${button_id}=    Get From Dictionary    ${NUMBER_BUTTONS}    ${number}
        Wait And Click Element    id=${button_id}
    ```

## 3. Flow Layer (Business Flows)
Keywords thực hiện các business flow hoàn chỉnh

### LoginFlow Keywords
- `Login With Valid Credentials`
  - Mục đích: Login với tài khoản hợp lệ
  - File: LoginFlow.robot
  - Ví dụ:
    ```robotframework
    Login With Valid Credentials    ${username}    ${password}
        Input Username    ${username}
        Input Password    ${password}
        Click Login Button
        Verify Login Success
    ```

### RegistrationFlow Keywords
- `Register New Personal Account`
  - Mục đích: Đăng ký tài khoản cá nhân mới
  - File: RegistrationFlow.robot
  - Ví dụ:
    ```robotframework
    Register New Personal Account    ${user_data}
        Fill Registration Form    ${user_data}
        Submit Registration
        Verify Registration Success
        Complete Email Verification
    ```

## 4. Spec Layer (Test Cases)
Keywords Gherkin-style cho test cases

### Login Test Keywords
- `Given User Is On Login Page`
  - Mục đích: Điều kiện tiên quyết - user đang ở trang login
  - File: login_smoke_tests.robot
  - Ví dụ:
    ```robotframework
    Given User Is On Login Page
        Navigate To Login Page
        Verify Login Page Loaded
    ```

- `When User Logs In With Valid Credentials`
  - Mục đích: Hành động - user login với thông tin hợp lệ
  - File: login_smoke_tests.robot
  - Ví dụ:
    ```robotframework
    When User Logs In With Valid Credentials    ${ADMIN_USER}
        Login With Valid Credentials    ${ADMIN_USER.username}    ${ADMIN_USER.password}
    ```

### Registration Test Keywords
- `Then Registration Should Be Successful`
  - Mục đích: Kết quả mong đợi - đăng ký thành công
  - File: registration_e2e_tests.robot
  - Ví dụ:
    ```robotframework
    Then Registration Should Be Successful
        Verify Registration Success Message
        Verify Account Created In Database
    ```

## Quy tắc sử dụng

1. Core Layer:
   - Chỉ sử dụng keywords từ thư viện hoặc custom base keywords
   - Không chứa business logic
   - Tái sử dụng cao

2. POM Layer:
   - Chỉ tương tác với elements trên một page cụ thể
   - Sử dụng Core Layer keywords
   - Không chứa business flow logic

3. Flow Layer:
   - Thực hiện các business flow hoàn chỉnh
   - Sử dụng POM Layer keywords
   - Có thể chứa verification steps

4. Spec Layer:
   - Sử dụng Gherkin syntax (Given/When/Then)
   - Gọi Flow Layer keywords
   - Dễ đọc và hiểu với business users

## Ví dụ Test Case hoàn chỉnh
