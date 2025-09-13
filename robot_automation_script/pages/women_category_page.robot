*** Settings ***
Documentation     Page object for the Women's category page
Library           SeleniumLibrary
Resource          ../resources/common.robot

*** Variables ***
# Navigation
${WOMEN_TAB}             css=a[title='Women']
${DRESSES_TAB}          css=a[title='Dresses']
${TSHIRTS_TAB}          css=a[title='T-shirts']

# Product Grid
${PRODUCT_CONTAINER}    css=.product_list
${PRODUCT_ITEM}        css=.product-container
${PRODUCT_NAME}        css=.product-name
${PRODUCT_PRICE}       css=.price.product-price
${PRODUCT_IMAGE}       css=.product_img_link img

# Filters
${CATEGORIES_FILTER}    css=#layered_category_4
${SIZE_FILTER_S}       css=#layered_id_attribute_group_1
${SIZE_FILTER_M}       css=#layered_id_attribute_group_2
${SIZE_FILTER_L}       css=#layered_id_attribute_group_3
${COLOR_FILTER}        css=.color-option
${PRICE_SLIDER}        css=#layered_price_slider

*** Keywords ***
Navigate To Women Category
    Wait And Click    ${WOMEN_TAB}
    Wait Until Page Contains Element With Timeout    ${PRODUCT_CONTAINER}

Click Product By Index
    [Arguments]    ${index}
    ${product_locator}=    Set Variable    (${PRODUCT_ITEM})[${index}]
    Wait And Click    ${product_locator}

Apply Size Filter
    [Arguments]    ${size}
    Run Keyword If    '${size}' == 'S'    Wait And Click    ${SIZE_FILTER_S}
    Run Keyword If    '${size}' == 'M'    Wait And Click    ${SIZE_FILTER_M}
    Run Keyword If    '${size}' == 'L'    Wait And Click    ${SIZE_FILTER_L}
    Sleep    2s    # Wait for filter to apply

Apply Color Filter
    [Arguments]    ${color_index}
    ${color_locator}=    Set Variable    (${COLOR_FILTER})[${color_index}]
    Wait And Click    ${color_locator}
    Sleep    2s    # Wait for filter to apply

Verify Product Elements Are Visible
    Wait Until Page Contains Element With Timeout    ${PRODUCT_NAME}
    Wait Until Page Contains Element With Timeout    ${PRODUCT_PRICE}
    Wait Until Page Contains Element With Timeout    ${PRODUCT_IMAGE}
