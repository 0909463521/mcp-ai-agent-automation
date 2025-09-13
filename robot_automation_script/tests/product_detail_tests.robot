*** Settings ***
Documentation     Test suite for product detail page functionality
Resource          ../pages/women_category_page.robot
Resource          ../pages/product_detail_page.robot
Resource          ../resources/common.robot

Test Setup       Run Keywords    Open Browser To Home Page    Navigate To Product Detail
Test Teardown    Close All Browsers And Log Results

*** Keywords ***
Navigate To Product Detail
    Navigate To Women Category
    Click Product By Index    1
    Verify Product Details Are Visible

*** Test Cases ***
Test Size Selection
    [Documentation]    Tests size selection functionality
    Select Product Size    S
    Sleep    1s
    Select Product Size    M
    Sleep    1s
    Select Product Size    L

Test Color Selection
    [Documentation]    Tests color selection functionality
    Select Product Color    1
    Sleep    1s    # Wait for image update
    Select Product Color    2
    Sleep    1s    # Wait for image update

Test Quantity Input
    [Documentation]    Tests quantity input functionality
    Set Product Quantity    1
    Set Product Quantity    2
    Set Product Quantity    5

Test Add To Cart Flow
    [Documentation]    Tests complete add to cart flow
    Select Product Size    M
    Select Product Color    1
    Set Product Quantity    2
    Add To Cart
