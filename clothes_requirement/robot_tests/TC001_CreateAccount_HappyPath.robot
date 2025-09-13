*** Settings ***
Documentation     Test case to verify successful account creation with valid information
Library           SeleniumLibrary
Resource          ../resources/common.robot
Resource          ../pages/create_account_page.robot

*** Variables ***
${TITLE}         Mr.
${FIRST_NAME}    John
${LAST_NAME}     Smith
${EMAIL}         john.smith@example.com
${PASSWORD}      Test123
${DOB_DAY}       15
${DOB_MONTH}     March
${DOB_YEAR}      1990

*** Test Cases ***
Create Account Happy Path
    [Documentation]    Verify user can create account with valid information
    [Setup]    Open Browser To Home Page
    
    Click Create Account Button
    Select Title    ${TITLE}
    Input First Name    ${FIRST_NAME}
    Input Last Name    ${LAST_NAME}
    Input Email    ${EMAIL}
    Input Password    ${PASSWORD}
    Select Date Of Birth    ${DOB_DAY}    ${DOB_MONTH}    ${DOB_YEAR}
    Select Newsletter Signup
    Submit Account Creation
    
    Verify Account Creation Success
    Verify User Is Logged In
    Verify Dashboard Redirect
    [Teardown]    Close Browser

*** Keywords ***
Verify Account Creation Success
    Wait Until Element Is Visible    ${SUCCESS_MESSAGE}
    Element Should Contain    ${SUCCESS_MESSAGE}    Account created successfully

Verify User Is Logged In
    Element Should Be Visible    ${USER_MENU}
    Element Should Contain    ${USER_MENU}    ${FIRST_NAME}

Verify Dashboard Redirect
    Location Should Contain    /account/dashboard
    Wait Until Element Is Visible    ${DASHBOARD_HEADER}
