*** Settings ***
Resource    ../Pages/CartPage.robot

*** Keywords ***
Recalculate Cart Quantity
    Add Backpack To Cart
    Click Element    ${PLUS}
    Cart Should Contain    2    $ 59.98
    Click Element    ${MINUS}
    Cart Should Contain    1    $ 29.99

Remove Last Product
    Add Backpack To Cart
    Click Element    ${REMOVE}
    Cart Should Be Empty

Keep Cart After Background
    Add Backpack To Cart
    Click Element    ${PLUS}
    Cart Should Contain    2    $ 59.98
    Press Keycode    3
    Wait Until Page Does Not Contain Element    ${TOTAL}    10s
    Activate Application    %{APP_PACKAGE}
    Cart Should Contain    2    $ 59.98

Require Positive Quantity
    Open Backpack
    Click Element    ${MINUS}
    Element Text Should Be    ${QUANTITY}    0
    Expect Element    ${ADD_TO_CART}    disabled
    Click Element    ${PLUS}
    Expect Element    ${ADD_TO_CART}    enabled
    Element Text Should Be    ${QUANTITY}    1

Start Empty Cart After Process Restart
    Add Backpack To Cart
    Terminate Application    %{APP_PACKAGE}
    Activate Application    %{APP_PACKAGE}
    Wait Until Page Contains Element    ${PRODUCT_IMAGE}    60s
    Click Element    accessibility_id=View cart
    Cart Should Be Empty
