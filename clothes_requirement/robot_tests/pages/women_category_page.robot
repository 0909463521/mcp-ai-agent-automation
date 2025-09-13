*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${WOMEN_MENU}               css:#women-menu

# Product Grid Elements
${PRODUCT_GRID}            css:.product-grid
${PRODUCT_CARD}           css:.product-card

# Filter Elements
${FILTER_CONTAINER}        css:.filters-container
${CATEGORY_FILTER}        css:#category-filter
${SIZE_FILTER}            css:#size-filter
${COLOR_FILTER}           css:#color-filter
${PROPERTIES_FILTER}      css:#properties-filter
${COMPOSITIONS_FILTER}    css:#compositions-filter
${STYLES_FILTER}          css:#styles-filter
${AVAILABILITY_FILTER}    css:#availability-filter
${CONDITION_FILTER}       css:#condition-filter
${PRICE_FILTER}           css:#price-filter

*** Keywords ***
Click Filter Option
    [Arguments]    ${filter_name}    ${option}
    Wait Until Element Is Visible    xpath://div[contains(@class, 'filter') and contains(., '${filter_name}')]
    Click Element    xpath://div[contains(@class, 'filter') and contains(., '${filter_name}')]//li[contains(., '${option}')]

Verify Filter Selection
    [Arguments]    ${filter_name}    ${option}
    Element Should Be Visible    xpath://div[contains(@class, 'filter') and contains(., '${filter_name}')]//li[contains(@class, 'selected') and contains(., '${option}')]
