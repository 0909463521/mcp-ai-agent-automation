*** Settings ***
Documentation     Page object for account creation functionality
Library           SeleniumLibrary
Library           FakerLibrary    #For generating random test data
Library           String
Resource          ../resources/common.robot

*** Variables ***
# Account Creation Locators
${SIGN_IN_LINK}           css=.login
${CREATE_ACCOUNT_BTN}     css=#SubmitCreate
${EMAIL_CREATE}           css=#email_create

# Registration Form Locators
${TITLE_MR}              css=#id_gender1
${TITLE_MRS}             css=#id_gender2
${FIRST_NAME_INPUT}      css=#customer_firstname
${LAST_NAME_INPUT}       css=#customer_lastname
${EMAIL_INPUT}           css=#email
${PASSWORD_INPUT}        css=#passwd
${DOB_DAYS}             css=#days
${DOB_MONTHS}           css=#months
${DOB_YEARS}            css=#years
${NEWSLETTER_CHECKBOX}   css=#newsletter
${SUBMIT_ACCOUNT}       css=#submitAccount

# Success/Error Messages
${SUCCESS_MESSAGE}      css=.alert.alert-success
${ERROR_MESSAGE}        css=.alert.alert-danger

*** Keywords ***
Navigate To Account Creation
    Wait And Click    ${SIGN_IN_LINK}
    Wait Until Element Is Visible    ${EMAIL_CREATE}

Enter Email For Account Creation
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${EMAIL_CREATE}    timeout=20s
    Clear Element Text    ${EMAIL_CREATE}
    Wait And Input Text    ${EMAIL_CREATE}    ${email}
    Wait Until Element Is Enabled    ${CREATE_ACCOUNT_BTN}    timeout=20s
    Wait And Click    ${CREATE_ACCOUNT_BTN}
    Wait Until Element Is Visible    ${FIRST_NAME_INPUT}    timeout=30s
    # Add verification that we're actually on the account creation form
    Page Should Not Contain Element    css=.alert.alert-danger    message=Email creation failed

Select Title
    [Arguments]    ${title}
    Run Keyword If    '${title}' == 'Mr.'    Wait And Click    ${TITLE_MR}
    Run Keyword If    '${title}' == 'Mrs.'    Wait And Click    ${TITLE_MRS}

Input Personal Information
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${password}
    # Clear fields first
    Clear Element Text    ${FIRST_NAME_INPUT}
    Clear Element Text    ${LAST_NAME_INPUT}
    Clear Element Text    ${EMAIL_INPUT}
    Clear Element Text    ${PASSWORD_INPUT}
    
    # Input information with validation
    Wait And Input Text    ${FIRST_NAME_INPUT}    ${firstname}
    ${actual_firstname}=    Get Element Attribute    ${FIRST_NAME_INPUT}    value
    Should Be Equal    ${actual_firstname}    ${firstname}
    
    Wait And Input Text    ${LAST_NAME_INPUT}    ${lastname}
    ${actual_lastname}=    Get Element Attribute    ${LAST_NAME_INPUT}    value
    Should Be Equal    ${actual_lastname}    ${lastname}
    
    Wait And Input Text    ${EMAIL_INPUT}    ${email}
    ${actual_email}=    Get Element Attribute    ${EMAIL_INPUT}    value
    Should Be Equal    ${actual_email}    ${email}
    
    Wait And Input Text    ${PASSWORD_INPUT}    ${password}
    # Don't verify password as it might be masked

Select Date Of Birth
    [Arguments]    ${day}    ${month}    ${year}
    Select From List By Value    ${DOB_DAYS}    ${day}
    Select From List By Value    ${DOB_MONTHS}    ${month}
    Select From List By Value    ${DOB_YEARS}    ${year}

Check Newsletter Signup
    Select Checkbox    ${NEWSLETTER_CHECKBOX}

Submit Account Creation
    Wait Until Element Is Enabled    ${SUBMIT_ACCOUNT}    timeout=20s
    Wait And Click    ${SUBMIT_ACCOUNT}
    Sleep    2s    # Wait for form submission

Verify Account Creation Success
    [Documentation]    Verifies that account creation was successful
    Wait Until Element Is Visible    ${SUCCESS_MESSAGE}    timeout=30s
    Element Should Be Visible    ${SUCCESS_MESSAGE}
    # Additional verifications
    Page Should Not Contain Element    ${ERROR_MESSAGE}
    Location Should Contain    my-account    message=Should be redirected to account page
    Page Should Contain Element    css=.account    message=User account section should be visible

Verify Account Creation Error
    [Documentation]    Verifies that account creation failed with proper error message
    Wait Until Element Is Visible    ${ERROR_MESSAGE}    timeout=20s
    Element Should Be Visible    ${ERROR_MESSAGE}
    ${error_text}=    Get Text    ${ERROR_MESSAGE}
    Should Not Be Empty    ${error_text}    message=Error message should not be empty
    Log    Error message received: ${error_text}

Generate Random User Data
    [Arguments]    ${locale}=en_US
    # Generate first name between 3-10 characters
    ${firstname_length}=    Evaluate    random.randint(3, 10)
    ${firstname}=    Generate Random String    ${firstname_length}    [LETTERS]
    ${firstname}=    Convert To Title Case    ${firstname}
    
    # Generate last name between 3-10 characters
    ${lastname_length}=    Evaluate    random.randint(3, 10)
    ${lastname}=     Generate Random String    ${lastname_length}    [LETTERS]
    ${lastname}=     Convert To Title Case    ${lastname}
    
    # Generate unique email with timestamp
    ${timestamp}=    Get Time    epoch
    ${email_base}=   Generate Random String    8    [LETTERS][NUMBERS]
    ${email}=        Set Variable    ${email_base}${timestamp}@testmail.com
    
    # Generate complex password
    ${letters}=      Generate Random String    6    [LETTERS]
    ${numbers}=      Generate Random String    3    [NUMBERS]
    ${special}=      Set Variable    @#$
    ${password}=     Set Variable    ${letters}${numbers}${special}
    
    Log    Generated Data - Email: ${email}, First Name: ${firstname}, Last Name: ${lastname}
    [Return]        ${email}    ${firstname}    ${lastname}    ${password}

Generate Random Address Data
    ${street_number}=    Generate Random String    3    [NUMBERS]
    ${street_name}=      Generate Random String    8    [LETTERS]
    ${street}=          Set Variable    ${street_number} ${street_name} Street
    ${city}=            Generate Random String    8    [LETTERS]
    ${state}=           Generate Random String    2    [LETTERS]
    ${postcode}=        Generate Random String    5    [NUMBERS]
    ${phone}=           Generate Random String    10    [NUMBERS]
    ${company}=         Generate Random String    10    [LETTERS]
    [Return]            ${street}    ${city}    ${state}    ${postcode}    ${phone}    ${company}

Generate Random Date Of Birth
    ${year}=    Evaluate    random.randint(1950, 2000)    random
    ${month}=   Evaluate    random.randint(1, 12)    random
    ${day}=     Evaluate    random.randint(1, 28)    random    # Using 28 to be safe for all months
    [Return]    ${day}    ${month}    ${year}

Create Random Account
    ${email}    ${firstname}    ${lastname}    ${password}=    Generate Random User Data
    ${day}    ${month}    ${year}=    Generate Random Date Of Birth
    
    Navigate To Account Creation
    Enter Email For Account Creation    ${email}
    Select Title    Mr.
    Input Personal Information    ${firstname}    ${lastname}    ${email}    ${password}
    Select Date Of Birth    ${day}    ${month}    ${year}
    Check Newsletter Signup
    Submit Account Creation
    [Return]    ${email}    ${password}
