*** Settings ***
Documentation     Test suite for account creation functionality
Resource          ../pages/account_creation_page.robot
Resource          ../resources/common.robot

Test Setup       Open Browser To Home Page
Test Teardown    Close All Browsers And Log Results

*** Variables ***
${VALID_EMAIL}         test.user@example.com
${VALID_PASSWORD}      Test123
${FIRST_NAME}         John
${LAST_NAME}          Smith

*** Test Cases ***
Create Account With US Locale Data
    [Documentation]    Tests account creation with US locale data
    ${email}    ${firstname}    ${lastname}    ${password}=    Generate Random User Data    locale=en_US
    Navigate To Account Creation
    Enter Email For Account Creation    ${email}
    Select Title    Mr.
    Input Personal Information    ${firstname}    ${lastname}    ${email}    ${password}
    ${day}    ${month}    ${year}=    Generate Random Date Of Birth
    Select Date Of Birth    ${day}    ${month}    ${year}
    Check Newsletter Signup
    Submit Account Creation
    Verify Account Creation Success

Create Account With French Locale Data
    [Documentation]    Tests account creation with French locale data
    ${email}    ${firstname}    ${lastname}    ${password}=    Generate Random User Data    locale=fr_FR
    Navigate To Account Creation
    Enter Email For Account Creation    ${email}
    Select Title    Mrs.
    Input Personal Information    ${firstname}    ${lastname}    ${email}    ${password}
    ${day}    ${month}    ${year}=    Generate Random Date Of Birth
    Select Date Of Birth    ${day}    ${month}    ${year}
    Check Newsletter Signup
    Submit Account Creation
    Verify Account Creation Success

Create Multiple Random Accounts With Different Locales
    [Documentation]    Tests creating multiple accounts with different locales
    @{locales}=    Create List    en_US    fr_FR    es_ES    de_DE
    FOR    ${locale}    IN    @{locales}
        ${email}    ${firstname}    ${lastname}    ${password}=    Generate Random User Data    locale=${locale}
        Navigate To Account Creation
        Enter Email For Account Creation    ${email}
        Select Title    Mr.
        Input Personal Information    ${firstname}    ${lastname}    ${email}    ${password}
        ${day}    ${month}    ${year}=    Generate Random Date Of Birth
        Select Date Of Birth    ${day}    ${month}    ${year}
        Check Newsletter Signup
        Submit Account Creation
        Verify Account Creation Success
        Close Browser
        Open Browser To Home Page
    END

Create Account With Complex Password
    [Documentation]    Tests account creation with complex password
    ${email}    ${firstname}    ${lastname}    ${password}=    Generate Random User Data
    ${complex_password}=    Generate Random Password
    Navigate To Account Creation
    Enter Email For Account Creation    ${email}
    Select Title    Mr.
    Input Personal Information    ${firstname}    ${lastname}    ${email}    ${complex_password}
    ${day}    ${month}    ${year}=    Generate Random Date Of Birth
    Select Date Of Birth    ${day}    ${month}    ${year}
    Check Newsletter Signup
    Submit Account Creation
    Verify Account Creation Success

Create Account With Missing Required Fields
    [Documentation]    Tests validation of required fields
    Navigate To Account Creation
    Enter Email For Account Creation    missing.fields@example.com
    Submit Account Creation
    Verify Account Creation Error
    
    # Test partial form completion
    Input Personal Information    ${FIRST_NAME}    ${EMPTY}    missing.fields@example.com    ${EMPTY}
    Submit Account Creation
    Verify Account Creation Error

Create Account With Invalid Inputs
    [Documentation]    Tests validation of invalid inputs
    Navigate To Account Creation
    
    # Test invalid email format
    Enter Email For Account Creation    invalid.email
    Verify Account Creation Error
    
    # Test with valid email but invalid data
    Enter Email For Account Creation    invalid.data@example.com
    Input Personal Information    123    456    invalid.data@example.com    a
    Select Date Of Birth    32    13    2030    # Invalid date
    Submit Account Creation
    Verify Account Creation Error

Create Account With Special Characters
    [Documentation]    Tests handling of special characters in name fields
    Navigate To Account Creation
    Enter Email For Account Creation    special.chars@example.com
    Input Personal Information    John@#$    Smith%^&    special.chars@example.com    ${VALID_PASSWORD}
    Select Date Of Birth    15    3    1990
    Submit Account Creation
    Verify Account Creation Error

Create Account With Long Values
    [Documentation]    Tests handling of very long input values
    Navigate To Account Creation
    ${long_text}=    Set Variable    ${{('x' * 100)}}
    Enter Email For Account Creation    long.values@example.com
    Input Personal Information    ${long_text}    ${long_text}    long.values@example.com    ${long_text}
    Select Date Of Birth    15    3    1990
    Submit Account Creation
    Verify Account Creation Error
