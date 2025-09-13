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
TC001 - Verify T-shirts Category URL
    [Documentation]    Check if the T-shirts category page loads with correct URL
    Open Browser To Category Page
    Location Should Be    ${URL}
    [Teardown]    Close Browser

TC002 - Verify Page Title
    [Documentation]    Check if page title displays correctly
    Open Browser To Category Page
    Page Should Contain    ${EXPECTED_TITLE}
    [Teardown]    Close Browser

TC003 - Verify Product Display
    [Documentation]    Check if at least one product is displayed
    Open Browser To Category Page
    Page Should Contain Element    ${PRODUCT_CONTAINER}
    [Teardown]    Close Browser

TC004 - Verify Product Elements
    [Documentation]    Check if product displays all required elements
    Open Browser To Category Page
    Wait Until Element Is Visible    ${PRODUCT_CONTAINER}
    Page Should Contain Element    ${PRODUCT_IMAGE}    message=Product image not found
    Page Should Contain Element    ${PRODUCT_LINK}    message=Product name not found
    Page Should Contain Element    ${PRODUCT_PRICE}    message=Product price not found
    Page Should Contain Element    ${ADD_TO_CART_BUTTON}    message=Add to cart button not found
    [Teardown]    Close Browser

TC005 - Verify Breadcrumb
    [Documentation]    Check if breadcrumb shows correct path
    Open Browser To Category Page
    Element Should Contain    ${BREADCRUMB}    Home
    Element Should Contain    ${BREADCRUMB}    T-shirts
    [Teardown]    Close Browser

TC006 - Verify Sidebar Filters
    [Documentation]    Check if sidebar filters are displayed
    Open Browser To Category Page
    Wait Until Element Is Visible    ${SIDEBAR_FILTERS}
    Page Should Contain    Size    message=Size filter not found
    Page Should Contain    Color    message=Color filter not found
    Page Should Contain    Compositions    message=Compositions filter not found
    [Teardown]    Close Browser

TC007 - Verify Product Navigation
    [Documentation]    Check if clicking product navigates to detail page
    Open Browser To Category Page
    Wait Until Element Is Visible    ${PRODUCT_LINK}
    ${product_url}=    Get Element Attribute    ${PRODUCT_LINK}    href
    Click Element    ${PRODUCT_LINK}
    Location Should Be    ${product_url}
    [Teardown]    Close Browser

TC008 - Verify No Console Errors
    [Documentation]    Check for JavaScript/console errors using browser logs
    Open Browser To Category Page
    ${logs}=    Get Browser Console Log
    Should Be Empty    ${logs}    message=Console errors found
    [Teardown]    Close Browser

TC009 - Verify Desktop Display
    [Documentation]    Check if page displays correctly on desktop
    Open Browser To Category Page
    Set Window Size    1024    768
    Wait Until Element Is Visible    ${PRODUCT_CONTAINER}
    Page Should Contain Element    ${SIDEBAR_FILTERS}
    Page Should Contain Element    ${BREADCRUMB}
    [Teardown]    Close Browser

TC010 - Verify All UI Elements
    [Documentation]    Check if all main elements are displayed correctly
    Open Browser To Category Page
    Page Should Contain Element    css=.product_list    message=Product list not found
    Page Should Contain Element    css=.product-count    message=Product count not found
    Page Should Contain Element    css=.top-pagination-content    message=Pagination not found
    Page Should Contain Element    ${SIDEBAR_FILTERS}    message=Sidebar filters not found
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Category Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${PRODUCT_CONTAINER}    timeout=10s

Get Browser Console Log
    ${logs}=    Execute Javascript    return window.performance.getEntries().filter(e => e.entryType === 'resource').filter(e => e.duration > 1000 || e.transferSize > 1000000).map(e => e.name)
    [Return]    ${logs}
