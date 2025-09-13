*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Locators
${CREATE_ACCOUNT_BTN}       css:#create-account-button
${TITLE_DROPDOWN}           css:#title
${FIRST_NAME_INPUT}         css:#firstName
${LAST_NAME_INPUT}         css:#lastName
${EMAIL_INPUT}             css:#email
${PASSWORD_INPUT}          css:#password
${DOB_DAY_SELECT}         css:#day
${DOB_MONTH_SELECT}       css:#month
${DOB_YEAR_SELECT}        css:#year
${NEWSLETTER_CHECKBOX}     css:#newsletter
${SUBMIT_BUTTON}          css:#submit-account
${SUCCESS_MESSAGE}        css:.success-message
${USER_MENU}             css:#user-menu
${DASHBOARD_HEADER}      css:#dashboard-header

*** Keywords ***
Click Create Account Button
    Wait Until Element Is Visible    ${CREATE_ACCOUNT_BTN}
    Click Element    ${CREATE_ACCOUNT_BTN}

Select Title
    [Arguments]    ${title}
    Wait Until Element Is Visible    ${TITLE_DROPDOWN}
    Select From List By Label    ${TITLE_DROPDOWN}    ${title}

Input First Name
    [Arguments]    ${firstname}
    Wait Until Element Is Visible    ${FIRST_NAME_INPUT}
    Input Text    ${FIRST_NAME_INPUT}    ${firstname}

Input Last Name
    [Arguments]    ${lastname}
    Wait Until Element Is Visible    ${LAST_NAME_INPUT}
    Input Text    ${LAST_NAME_INPUT}    ${lastname}

Input Email
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${EMAIL_INPUT}
    Input Text    ${EMAIL_INPUT}    ${email}

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    ${PASSWORD_INPUT}
    Input Text    ${PASSWORD_INPUT}    ${password}

Select Date Of Birth
    [Arguments]    ${day}    ${month}    ${year}
    Wait Until Element Is Visible    ${DOB_DAY_SELECT}
    Select From List By Value    ${DOB_DAY_SELECT}    ${day}
    Select From List By Label    ${DOB_MONTH_SELECT}    ${month}
    Select From List By Value    ${DOB_YEAR_SELECT}    ${year}

Select Newsletter Signup
    Wait Until Element Is Visible    ${NEWSLETTER_CHECKBOX}
    Select Checkbox    ${NEWSLETTER_CHECKBOX}

Submit Account Creation
    Wait Until Element Is Visible    ${SUBMIT_BUTTON}
    Click Element    ${SUBMIT_BUTTON}
