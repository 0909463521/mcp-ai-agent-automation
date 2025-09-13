*** Settings ***
Documentation     Test case to verify navigation and display of Women's category products
Library           SeleniumLibrary
Resource          ../resources/common.robot
Resource          ../pages/women_category_page.robot
Resource          ../pages/product_detail_page.robot

*** Test Cases ***
Browse Women Category Navigation
    [Documentation]    Verify basic navigation and display of Women's category products
    [Setup]    Open Browser To Home Page
    
    Navigate To Women Category
    Verify Category Page Elements
    Verify Filter Options
    Navigate To Product Detail
    Verify Product Detail Page Elements
    
    [Teardown]    Close Browser

*** Keywords ***
Navigate To Women Category
    Wait Until Element Is Visible    ${WOMEN_MENU}
    Click Element    ${WOMEN_MENU}
    Wait Until Page Contains Element    ${PRODUCT_GRID}

Verify Category Page Elements
    Page Should Contain Element    ${PRODUCT_GRID}
    @{product_cards}=    Get WebElements    ${PRODUCT_CARD}
    Length Should Be    ${product_cards}    greater than    0
    FOR    ${card}    IN    @{product_cards}
        Element Should Be Visible    ${card}//img    #Product Image
        Element Should Be Visible    ${card}//h3    #Product Name
        Element Should Be Visible    ${card}//*[contains(@class, "price")]    #Price
        Element Should Be Visible    ${card}//*[contains(@class, "availability")]    #Availability
    END

Verify Filter Options
    @{expected_filters}=    Create List    Categories    Size    Color    Properties    
    ...    Compositions    Styles    Availability    Condition    Price
    
    FOR    ${filter}    IN    @{expected_filters}
        Element Should Be Visible    xpath://div[contains(@class, 'filter') and contains(., '${filter}')]
        Element Should Be Enabled    xpath://div[contains(@class, 'filter') and contains(., '${filter}')]
    END

Navigate To Product Detail
    @{product_cards}=    Get WebElements    ${PRODUCT_CARD}
    Click Element    ${product_cards}[0]
    Wait Until Page Contains Element    ${PRODUCT_DETAIL_CONTAINER}

Verify Product Detail Page Elements
    @{detail_elements}=    Create List    
    ...    ${PRODUCT_NAME}    
    ...    ${PRODUCT_IMAGES}
    ...    ${PRODUCT_PRICE}
    ...    ${PRODUCT_AVAILABILITY}
    ...    ${PRODUCT_DESCRIPTION}
    ...    ${PRODUCT_SIZES}
    ...    ${PRODUCT_COLORS}
    ...    ${PRODUCT_QUANTITY}
    ...    ${ADD_TO_CART_BTN}
    ...    ${PRODUCT_COMPOSITION}
    ...    ${PRODUCT_STYLE}
    ...    ${PRODUCT_CATEGORY}
    
    FOR    ${element}    IN    @{detail_elements}
        Element Should Be Visible    ${element}
    END
