*** Settings ***
Resource    ../ressources/lab3.robot

Suite Setup    Create Session To eBay API
Suite Teardown    Delete All Sessions

*** Test Cases ***

# === CREATE SHIPPING FULFILLMENT TESTS ===

TC_3001_Create_Shipping_Fulfillment_Valid_Data
    [Documentation]    Scénario passant : Teste la création d'un fulfillment avec des données valides
    [Tags]    create    positive    TC_3001
    ${response}=    Create Shipping Fulfillment With Valid Data    ${VALID_ORDER_ID}
    Validate Successful Response    ${response}    ${HTTP_CREATED}
    Validate Location Header    ${response}
    Log To Console    TC_3001 PASSED: Fulfillment créé avec succès

TC_3002_Create_Shipping_Fulfillment_Invalid_Payload
    [Documentation]    Scénario non passant : Teste la création d'un fulfillment avec un payload invalide
    [Tags]    create    negative    TC_3002
    ${response}=    Create Shipping Fulfillment With Invalid Payload    ${VALID_ORDER_ID}
    Validate Error Response    ${response}    ${HTTP_BAD_REQUEST}
    Log To Console    TC_3002 PASSED: Erreur 400 retournée pour payload invalide

# === GET SHIPPING FULFILLMENT TESTS ===

TC_3003_Get_Shipping_Fulfillment_Valid_IDs
    [Documentation]    Scénario passant : Teste la récupération d'un fulfillment avec des IDs valides
    [Tags]    get    positive    TC_3003
    ${response}=    Get Shipping Fulfillment With Valid IDs    ${VALID_ORDER_ID}    ${VALID_FULFILLMENT_ID}
    Validate Successful Response    ${response}    ${HTTP_OK}
    Validate Fulfillment Response Structure    ${response}
    Log To Console    TC_3003 PASSED: Fulfillment récupéré avec succès

TC_3004_Get_Shipping_Fulfillment_Invalid_Order_ID
    [Documentation]    Scénario non passant : Teste la récupération d'un fulfillment avec un Order ID invalide
    [Tags]    get    negative    TC_3004
    ${response}=    Get Shipping Fulfillment With Invalid Order ID    ${INVALID_ORDER_ID}    ${VALID_FULFILLMENT_ID}
    Validate Error Response    ${response}    ${HTTP_NOT_FOUND}
    Log To Console    TC_3004 PASSED: Erreur 404 retournée pour Order ID invalide

# === GET SHIPPING FULFILLMENTS TESTS ===

TC_3005_Get_Shipping_Fulfillments_Valid_Order_ID
    [Documentation]    Scénario passant : Teste la récupération de tous les fulfillments avec un Order ID valide
    [Tags]    getall    positive    TC_3005
    ${response}=    Get Shipping Fulfillments With Valid Order ID    ${VALID_ORDER_ID}
    Validate Successful Response    ${response}    ${HTTP_OK}
    Validate Fulfillments Response Structure    ${response}
    Log To Console    TC_3005 PASSED: Liste des fulfillments récupérée avec succès

TC_3006_Get_Shipping_Fulfillments_Invalid_Order_ID
    [Documentation]    Scénario non passant : Teste la récupération de tous les fulfillments avec un Order ID invalide
    [Tags]    getall    negative    TC_3006
    ${response}=    Get Shipping Fulfillments With Invalid Order ID    ${INVALID_ORDER_ID}
    Validate Error Response    ${response}    ${HTTP_NOT_FOUND}
    Log To Console    TC_3006 PASSED: Erreur 404 retournée pour Order ID invalide