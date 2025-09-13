*** Settings ***
Library    SeleniumLibrary
Documentation    Automation Practice Search Test Suite

*** Variables ***
${URL}               http://www.automationpractice.pl/index.php
${BROWSER}           Chrome
${SEARCH_TEXT}       xin chao
${PRODUCT_TEXT}      Blouse

# Locators
${SEARCH_BOX}        id=search_query_top
${SEARCH_BUTTON}     name=submit_search
${BLOUSE_LINK}      link=Blouse

*** Test Cases ***
Search And Select Product
    [Documentation]    Test search functionality and select product
    [Tags]    search    product
    Open Browser To Shop
    Search For Product    ${SEARCH_TEXT}
    Click Product Link    ${PRODUCT_TEXT}
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Shop
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${SEARCH_BOX}    timeout=10s

Search For Product
    [Arguments]    ${search_term}
    Input Text    ${SEARCH_BOX}    ${search_term}
    Click Button    ${SEARCH_BUTTON}
    Wait Until Page Contains    ${PRODUCT_TEXT}    timeout=10s

Click Product Link
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    ${BLOUSE_LINK}    timeout=10s
    Click Link    ${BLOUSE_LINK}
    Wait Until Page Contains    Product    timeout=10s    # Verify product page loaded
