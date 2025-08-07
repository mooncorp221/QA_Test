*** Settings ***
Library    RequestsLibrary
Variables    pageobject/variables.py

*** Test Cases ***
Debug_eBay_API_Response
    [Documentation]    Test pour debug la réponse de l'API eBay
    Log To Console    Creating session to eBay API: ${BASE_URL}
    Create Session    ebay    ${BASE_URL}    timeout=30

    Log To Console    Testing token format: ${ACCESS_TOKEN}
    Log To Console    Headers being sent: ${HEADERS}

    # Test simple GET first
    ${response}=    GET On Session    ebay    /order/${VALID_ORDER_ID}/shipping_fulfillment    headers=${HEADERS}    expected_status=any
    Log To Console    GET Response Status: ${response.status_code}
    Log To Console    GET Response Text: ${response.text}

    # Test POST
    ${response}=    POST On Session    ebay    /order/${VALID_ORDER_ID}/shipping_fulfillment    json=${CREATE_FULFILLMENT_VALID_PAYLOAD}    headers=${HEADERS}    expected_status=any
    Log To Console    POST Response Status: ${response.status_code}
    Log To Console    POST Response Text: ${response.text}
