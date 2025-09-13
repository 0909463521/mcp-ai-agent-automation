*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Product Detail Page Elements
${PRODUCT_DETAIL_CONTAINER}    css:#product-detail
${PRODUCT_NAME}               css:.product-name
${PRODUCT_IMAGES}            css:.product-images
${PRODUCT_PRICE}             css:.product-price
${PRODUCT_AVAILABILITY}      css:.product-availability
${PRODUCT_DESCRIPTION}       css:.product-description
${PRODUCT_SIZES}             css:.product-sizes
${PRODUCT_COLORS}            css:.product-colors
${PRODUCT_QUANTITY}          css:#quantity
${ADD_TO_CART_BTN}          css:#add-to-cart
${PRODUCT_COMPOSITION}       css:.product-composition
${PRODUCT_STYLE}             css:.product-style
${PRODUCT_CATEGORY}          css:.product-category

*** Keywords ***
Select Product Size
    [Arguments]    ${size}
    Wait Until Element Is Visible    ${PRODUCT_SIZES}
    Click Element    xpath://div[contains(@class, 'size-option') and contains(., '${size}')]

Select Product Color
    [Arguments]    ${color}
    Wait Until Element Is Visible    ${PRODUCT_COLORS}
    Click Element    xpath://div[contains(@class, 'color-option') and contains(., '${color}')]

Set Product Quantity
    [Arguments]    ${quantity}
    Wait Until Element Is Visible    ${PRODUCT_QUANTITY}
    Input Text    ${PRODUCT_QUANTITY}    ${quantity}

Add Product To Cart
    Wait Until Element Is Visible    ${ADD_TO_CART_BTN}
    Click Element    ${ADD_TO_CART_BTN}
