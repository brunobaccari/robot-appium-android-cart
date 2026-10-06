*** Variables ***
${PRODUCT_IMAGE}    id=%{APP_PACKAGE}:id/productIV
${PRODUCT_NAME}     id=%{APP_PACKAGE}:id/productTV
${ADD_TO_CART}      id=%{APP_PACKAGE}:id/cartBt
${PLUS}             id=%{APP_PACKAGE}:id/plusIV
${MINUS}            id=%{APP_PACKAGE}:id/minusIV
${QUANTITY}         id=%{APP_PACKAGE}:id/noTV
${TOTAL}            id=%{APP_PACKAGE}:id/totalPriceTV
${REMOVE}           id=%{APP_PACKAGE}:id/removeBt

*** Keywords ***
Open Backpack
    Click Element    ${PRODUCT_IMAGE}
    Wait Until Page Contains Element    ${PRODUCT_NAME}
    Element Text Should Be    ${PRODUCT_NAME}    Sauce Labs Backpack
    Get Webelement    android=new UiScrollable(new UiSelector().scrollable(true)).setMaxSearchSwipes(5).scrollIntoView(new UiSelector().resourceId("%{APP_PACKAGE}:id/cartBt"))
    Wait Until Page Contains Element    ${ADD_TO_CART}

Add Backpack To Cart
    Open Backpack
    Click Element    ${ADD_TO_CART}
    Click Element    accessibility_id=View cart
    Wait Until Page Contains Element    ${TOTAL}
    Page Should Contain Text    Sauce Labs Backpack
    Cart Should Contain    1    $ 29.99

Cart Should Contain
    [Arguments]    ${quantity}    ${total}
    Wait Until Page Contains Element    ${TOTAL}
    Element Text Should Be    ${QUANTITY}    ${quantity}
    Element Text Should Be    ${TOTAL}    ${total}
    Element Text Should Be    id=%{APP_PACKAGE}:id/itemsTV    ${quantity} Items

Cart Should Be Empty
    Wait Until Page Contains    No Items
    Page Should Not Contain Text    Sauce Labs Backpack
    Page Should Not Contain Text    Proceed To Checkout
