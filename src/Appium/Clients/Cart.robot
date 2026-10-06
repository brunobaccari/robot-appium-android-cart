*** Settings ***
Resource         ../Resources/Application.robot
Resource         ../TestCases/Cart.robot
Test Setup       Open Demo App
Test Teardown    Close Demo App

*** Test Cases ***
CT: Recalcular Quantidade E Total
    [Tags]    carrinho    integridade
    Recalculate Cart Quantity

CT: Remover Ultimo Produto
    [Tags]    carrinho
    Remove Last Product

CT: Retomar Carrinho Do Background
    [Tags]    ciclo-de-vida
    Keep Cart After Background

CT: Bloquear Quantidade Zero
    [Tags]    limite
    Require Positive Quantity

CT: Reiniciar Carrinho Apos Encerrar Processo
    [Tags]    ciclo-de-vida
    Start Empty Cart After Process Restart
