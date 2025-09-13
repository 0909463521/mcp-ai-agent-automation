*** Settings ***
Documentation     Page object for product details page
Library           SeleniumLibrary
Resource          ../resources/common.robot

*** Variables ***
# Product Details
${PRODUCT_NAME_DETAIL}      css=h1[itemprop='name']
${PRODUCT_PRICE_DETAIL}     css=#our_price_display
${PRODUCT_DESC}             css=#short_description_content
${ADD_TO_CART_BTN}         css=#add_to_cart button
${QUANTITY_INPUT}          css=#quantity_wanted
${SIZE_DROPDOWN}           css=#group_1
${COLOR_OPTIONS}           css=#color_to_pick_list li
${THUMBNAIL_IMAGES}        css=#thumbs_list_frame img

*** Keywords ***
Verify Product Details Are Visible
    Wait Until Page Contains Element With Timeout    ${PRODUCT_NAME_DETAIL}
    Wait Until Page Contains Element With Timeout    ${PRODUCT_PRICE_DETAIL}
    Wait Until Page Contains Element With Timeout    ${PRODUCT_DESC}
    Wait Until Page Contains Element With Timeout    ${ADD_TO_CART_BTN}

Select Product Size
    [Arguments]    ${size}
    Wait Until Page Contains Element With Timeout    ${SIZE_DROPDOWN}
    Select From List By Label    ${SIZE_DROPDOWN}    ${size}

Select Product Color
    [Arguments]    ${color_index}
    ${color_locator}=    Set Variable    (${COLOR_OPTIONS})[${color_index}]
    Wait And Click    ${color_locator}

Set Product Quantity
    [Arguments]    ${quantity}
    Wait And Input Text    ${QUANTITY_INPUT}    ${quantity}

Add To Cart
    Wait And Click    ${ADD_TO_CART_BTN}
    Wait Until Element Is Visible    css=.layer_cart_product h2
    Element Should Contain    css=.layer_cart_product h2    Product successfully added
