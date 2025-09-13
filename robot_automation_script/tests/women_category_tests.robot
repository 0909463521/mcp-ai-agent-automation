*** Settings ***
Documentation     Test suite for browsing women's category and product navigation
Resource          ../pages/women_category_page.robot
Resource          ../pages/product_detail_page.robot
Resource          ../resources/common.robot

Test Setup       Open Browser To Home Page
Test Teardown    Close All Browsers And Log Results

*** Test Cases ***
Verify Women Category Navigation And Display
    [Documentation]    Tests basic navigation and product display in women's category
    Navigate To Women Category
    Verify Product Elements Are Visible
    
    # Click first product and verify details
    Click Product By Index    1
    Verify Product Details Are Visible

Test Product Filtering
    [Documentation]    Tests product filtering functionality
    Navigate To Women Category
    
    # Test size filter
    Apply Size Filter    M
    Verify Product Elements Are Visible
    
    # Test color filter
    Apply Color Filter    1
    Verify Product Elements Are Visible

Test Product Detail Page Functionality
    [Documentation]    Tests product detail page interactions
    Navigate To Women Category
    Click Product By Index    1
    Verify Product Details Are Visible
    
    # Test product options
    Select Product Size    M
    Select Product Color    1
    Set Product Quantity    2
    Add To Cart
