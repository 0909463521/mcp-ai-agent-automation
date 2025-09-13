*** Settings ***
Library    SeleniumLibrary
Documentation    Automation Practice T-shirts Navigation Test Suite

*** Variables ***
${URL}               http://www.automationpractice.pl/index.php
${BROWSER}           Chrome

# Locators
${TSHIRTS_MENU}      css=[title="T-shirts"]
${PRODUCT_AVAILABLE}  xpath=//*[contains(text(),'sản phẩm hiện có')]

*** Test Cases ***
Navigate To TShirts And Select Available Product
    [Documentation]    Test navigation to T-shirts and select available product
    [Tags]    navigation    product
    Open Browser To Shop
    Click TShirts Category
    Click Available Product
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Shop
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${TSHIRTS_MENU}    timeout=10s

Click TShirts Category
    Wait Until Element Is Visible    ${TSHIRTS_MENU}    timeout=10s
    Click Element    ${TSHIRTS_MENU}
    # Wait for page to load
    Sleep    2s

Click Available Product
    Wait Until Element Is Visible    ${PRODUCT_AVAILABLE}    timeout=10s
    Click Element    ${PRODUCT_AVAILABLE}
    # Wait for product page to load
    Sleep    2s
    # Verify we're on a product page
    Wait Until Page Contains Element    css=.product-container    timeout=10s
