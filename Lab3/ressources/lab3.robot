*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

Variables    ../pageobject/variables.py

*** Keywords ***
Create Session To eBay API
    Log To Console    Creating session to eBay Fulfillment API: ${BASE_URL}
    Create Session    ebay    ${BASE_URL}    timeout=${REQUEST_TIMEOUT}
    Log To Console    Session created successfully.

# === CREATE SHIPPING FULFILLMENT KEYWORDS ===

Create Shipping Fulfillment With Valid Data
    [Arguments]    ${order_id}
    Log To Console    Creating shipping fulfillment for order: ${order_id}
    ${endpoint}=    Replace String    ${CREATE_FULFILLMENT_ENDPOINT}    {orderId}    ${order_id}
    ${response}=    POST On Session    ebay    ${endpoint}    json=${CREATE_FULFILLMENT_VALID_PAYLOAD}    headers=${HEADERS}    expected_status=${HTTP_CREATED}
    Log To Console    POST ${endpoint} - Status: ${response.status_code}
    RETURN    ${response}

Create Shipping Fulfillment With Invalid Payload
    [Arguments]    ${order_id}
    Log To Console    Creating shipping fulfillment with invalid payload for order: ${order_id}
    ${endpoint}=    Replace String    ${CREATE_FULFILLMENT_ENDPOINT}    {orderId}    ${order_id}
    ${response}=    POST On Session    ebay    ${endpoint}    json=${CREATE_FULFILLMENT_INVALID_PAYLOAD}    headers=${HEADERS}    expected_status=${HTTP_BAD_REQUEST}
    Log To Console    POST ${endpoint} - Status: ${response.status_code}
    RETURN    ${response}

Create Shipping Fulfillment With Invalid Order ID
    [Arguments]    ${order_id}
    Log To Console    Creating shipping fulfillment with invalid order ID: ${order_id}
    ${endpoint}=    Replace String    ${CREATE_FULFILLMENT_ENDPOINT}    {orderId}    ${order_id}
    ${response}=    POST On Session    ebay    ${endpoint}    json=${CREATE_FULFILLMENT_VALID_PAYLOAD}    headers=${HEADERS}    expected_status=${HTTP_NOT_FOUND}
    Log To Console    POST ${endpoint} - Status: ${response.status_code}
    RETURN    ${response}

# === GET SHIPPING FULFILLMENT KEYWORDS ===

Get Shipping Fulfillment With Valid IDs
    [Arguments]    ${order_id}    ${fulfillment_id}
    Log To Console    Getting shipping fulfillment for order: ${order_id}, fulfillment: ${fulfillment_id}
    ${endpoint}=    Replace String    ${GET_FULFILLMENT_ENDPOINT}    {orderId}    ${order_id}
    ${endpoint}=    Replace String    ${endpoint}    {fulfillmentId}    ${fulfillment_id}
    ${response}=    GET On Session    ebay    ${endpoint}    headers=${HEADERS}    expected_status=${HTTP_OK}
    Log To Console    GET ${endpoint} - Status: ${response.status_code}
    RETURN    ${response}

Get Shipping Fulfillment With Invalid Order ID
    [Arguments]    ${order_id}    ${fulfillment_id}
    Log To Console    Getting shipping fulfillment with invalid order ID: ${order_id}
    ${endpoint}=    Replace String    ${GET_FULFILLMENT_ENDPOINT}    {orderId}    ${order_id}
    ${endpoint}=    Replace String    ${endpoint}    {fulfillmentId}    ${fulfillment_id}
    ${response}=    GET On Session    ebay    ${endpoint}    headers=${HEADERS}    expected_status=${HTTP_NOT_FOUND}
    Log To Console    GET ${endpoint} - Status: ${response.status_code}
    RETURN    ${response}

Get Shipping Fulfillment With Invalid Fulfillment ID
    [Arguments]    ${order_id}    ${fulfillment_id}
    Log To Console    Getting shipping fulfillment with invalid fulfillment ID: ${fulfillment_id}
    ${endpoint}=    Replace String    ${GET_FULFILLMENT_ENDPOINT}    {orderId}    ${order_id}
    ${endpoint}=    Replace String    ${endpoint}    {fulfillmentId}    ${fulfillment_id}
    ${response}=    GET On Session    ebay    ${endpoint}    headers=${HEADERS}    expected_status=${HTTP_NOT_FOUND}
    Log To Console    GET ${endpoint} - Status: ${response.status_code}
    RETURN    ${response}

# === GET SHIPPING FULFILLMENTS KEYWORDS ===

Get Shipping Fulfillments With Valid Order ID
    [Arguments]    ${order_id}
    Log To Console    Getting all shipping fulfillments for order: ${order_id}
    ${endpoint}=    Replace String    ${GET_FULFILLMENTS_ENDPOINT}    {orderId}    ${order_id}
    ${response}=    GET On Session    ebay    ${endpoint}    headers=${HEADERS}    expected_status=${HTTP_OK}
    Log To Console    GET ${endpoint} - Status: ${response.status_code}
    RETURN    ${response}

Get Shipping Fulfillments With Invalid Order ID
    [Arguments]    ${order_id}
    Log To Console    Getting shipping fulfillments with invalid order ID: ${order_id}
    ${endpoint}=    Replace String    ${GET_FULFILLMENTS_ENDPOINT}    {orderId}    ${order_id}
    ${response}=    GET On Session    ebay    ${endpoint}    headers=${HEADERS}    expected_status=${HTTP_NOT_FOUND}
    Log To Console    GET ${endpoint} - Status: ${response.status_code}
    RETURN    ${response}

# === VALIDATION KEYWORDS ===

Validate Successful Response
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}
    Log To Console    Response status code validated: ${expected_status}

Validate Error Response
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}
    Should Not Be Empty    ${response.json()}
    Log To Console    Error response validated with status: ${expected_status}

Validate Response Contains Field
    [Arguments]    ${response}    ${field_name}
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    ${field_name}
    Log To Console    Response contains required field: ${field_name}

Validate Response Does Not Contain Field
    [Arguments]    ${response}    ${field_name}
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Not Contain Key    ${json_response}    ${field_name}
    Log To Console    Response correctly does not contain field: ${field_name}

Validate Fulfillment Response Structure
    [Arguments]    ${response}
    FOR    ${field}    IN    @{EXPECTED_FULFILLMENT_FIELDS}
        Validate Response Contains Field    ${response}    ${field}
    END
    Log To Console    Fulfillment response structure validated.

Validate Fulfillments Response Structure
    [Arguments]    ${response}
    FOR    ${field}    IN    @{EXPECTED_FULFILLMENTS_FIELDS}
        Validate Response Contains Field    ${response}    ${field}
    END
    Log To Console    Fulfillments response structure validated.

Validate Location Header
    [Arguments]    ${response}
    ${headers}=    Set Variable    ${response.headers}
    Dictionary Should Contain Key    ${headers}    Location
    ${location}=    Get From Dictionary    ${headers}    Location
    Should Contain    ${location}    shipping_fulfillment
    Log To Console    Location header validated: ${location}
