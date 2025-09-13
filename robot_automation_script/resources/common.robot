*** Settings ***
Documentation     Common resources and variables for AutomationPractice.pl website
Library           SeleniumLibrary
Library           String
Library           DateTime
Library           FakerLibrary

*** Variables ***
${BROWSER}               chrome
${BASE_URL}             http://www.automationpractice.pl
${DEFAULT_TIMEOUT}      20s
${IMPLICIT_WAIT}        10s

*** Keywords ***
Open Browser To Home Page
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Wait Until Element Is Visible    xpath://body

Close All Browsers And Log Results
    Close All Browsers

Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    Click Element    ${locator}

Wait And Input Text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    Input Text    ${locator}    ${text}

Wait Until Page Contains Element With Timeout
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    ${DEFAULT_TIMEOUT}

Generate Random String With Timestamp
    [Arguments]    ${prefix}=    ${length}=10
    ${random}=    Generate Random String    ${length}    [LETTERS]
    ${timestamp}=    Get Time    epoch
    [Return]    ${prefix}${random}${timestamp}

Set Test Locale
    [Arguments]    ${locale}=en_US
    Import Library    FakerLibrary    locale=${locale}    WITH NAME    faker_${locale}
    Set Library Search Order    faker_${locale}

Generate Unique Email
    ${username}=    Generate Random String    8    [LETTERS]
    ${timestamp}=    Get Time    epoch
    ${domain}=      Set Variable    example.com
    [Return]        ${username}${timestamp}@${domain}

Generate Complex Password
    ${length}=      Set Variable    12
    ${letters}=     Generate Random String    4    [LETTERS]
    ${digits}=      Generate Random String    4    [NUMBERS]
    ${special}=     Set Variable    !@#$
    ${password}=    Set Variable    ${letters}${digits}${special}
    [Return]        ${password}
