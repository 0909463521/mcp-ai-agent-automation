*** Settings ***
Library    SeleniumLibrary
Documentation    T-shirts Category Page Automated Tests

*** Variables ***
${URL}                    http://www.automationpractice.pl/index.php?id_category=5&controller=category
${BROWSER}                Chrome
${EXPECTED_TITLE}         T-shirts
${PRODUCT_CONTAINER}      css=.product-container
${ADD_TO_CART_BUTTON}     css=.ajax_add_to_cart_button
${BREADCRUMB}            css=.breadcrumb
${SIDEBAR_FILTERS}       css=#layered_block_left
${PRODUCT_LINK}         css=.product-name
${PRODUCT_IMAGE}        css=.product_img_link img
${PRODUCT_PRICE}        css=.content_price

*** Test Cases ***
Verify T-shirts Category URL
    [Documentation]    Verify the correct URL for T-shirts category
    Open Browser To Category Page
    Location Should Be    ${URL}
    [Teardown]    Close Browser

Verify Page Title
    [Documentation]    Verify the page title shows T-shirts
    Open Browser To Category Page
    Page Should Contain    ${EXPECTED_TITLE}
    [Teardown]    Close Browser

Verify Product Display And Elements
    [Documentation]    Verify products are displayed with all required elements
    Open Browser To Category Page
    Wait Until Element Is Visible    ${PRODUCT_CONTAINER}
    Page Should Contain Element    ${PRODUCT_IMAGE}
    Page Should Contain Element    ${PRODUCT_LINK}
    Page Should Contain Element    ${PRODUCT_PRICE}
    Page Should Contain Element    ${ADD_TO_CART_BUTTON}
    [Teardown]    Close Browser

Verify Breadcrumb Navigation
    [Documentation]    Verify breadcrumb shows correct path
    Open Browser To Category Page
    Element Should Contain    ${BREADCRUMB}    Home
    Element Should Contain    ${BREADCRUMB}    T-shirts
    [Teardown]    Close Browser

Verify Sidebar Filters
    [Documentation]    Verify sidebar filters are present
    Open Browser To Category Page
    Wait Until Element Is Visible    ${SIDEBAR_FILTERS}
    Page Should Contain    Size
    Page Should Contain    Color
    Page Should Contain    Compositions
    [Teardown]    Close Browser

Verify Product Navigation
    [Documentation]    Verify clicking product navigates to detail page
    Open Browser To Category Page
    Wait Until Element Is Visible    ${PRODUCT_LINK}
    ${product_url}=    Get Element Attribute    ${PRODUCT_LINK}    href
    Click Element    ${PRODUCT_LINK}
    Location Should Be    ${product_url}
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Category Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${PRODUCT_CONTAINER}    timeout=10s
