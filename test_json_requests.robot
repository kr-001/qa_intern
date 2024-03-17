*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       http://localhost:5000
${SESSION_NAME}   my_session
${HEADERS}        Content-Type=application/json

*** Test Cases ***
Valid POST Request Test
    [Documentation]    Test the correct processing of a POST request with valid JSON payload.
    Create Session    ${SESSION_NAME}    ${BASE_URL}
    &{headers}=    Create Dictionary    Content-Type    application/json
    ${data}=    Create Dictionary    name=John    email=john@example.com
    ${response}=    POST On Session    ${SESSION_NAME}    /submit-json    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    ${response_data}=    Set Variable    ${response.json()}
    Should Contain    ${response_data["message"]}    Data received successfully!
    Dictionary Should Contain Key    ${response_data["data"]}    id
    Dictionary Should Contain Key    ${response_data["data"]}    name
    Dictionary Should Contain Key    ${response_data["data"]}    email
    Dictionary Should Contain Key    ${response_data["data"]}    created_at


Submit Form Data Test
    [Documentation]    Test submitting form data to the /submit-data endpoint
    [Tags]             submit-data
    Create Session    Submit Data    ${BASE_URL}
    ${data}=          Create Dictionary    name=John Doe    email=johndoe@example.com
    ${response}=      POST On Session    Submit Data    /submit-data    data=${data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_data}=    Set Variable    ${response.json()}
    Should Contain    ${response_data["message"]}    Form data received successfully
    Dictionary Should Contain Key    ${response_data["data"]}    id
    Dictionary Should Contain Key    ${response_data["data"]}    created_at

Test Method Not Allowed for /submit-json
    [Documentation]    Verify that the /submit-json endpoint returns 405 Method Not Allowed when a wrong request method is used.
    Create Session    Submit Json Session    http://localhost:5000
    ${response}=    Run Keyword And Ignore Error    DELETE On Session    Submit Json Session    /submit-json
    Run Keyword If    '${response[0]}' != 'FAIL'    Handle Error    ${response}

Test Method Not Allowed for /submit-data
    [Documentation]    Verify that the /submit-data endpoint returns 405 Method Not Allowed when a wrong request method is used.
    Create Session    Submit Data Session    http://localhost:5000
    ${response}=    Run Keyword And Ignore Error    GET On Session    Submit Data Session    /submit-data
    Run Keyword If    '${response[0]}' != 'FAIL'    Handle Error    ${response}

Test Missing Required Fields
    Create Session    Test Session    http://localhost:5000
    ${payload}=    Create Dictionary    name=John
    ${response}=    Run Keyword And Ignore Error    POST On Session    Test Session    /submit-json    json=${payload}
    Run Keyword If    '${response[0]}' != 'FAIL'    Handle Error    ${response}

*** Keywords ***
Handle Error
    [Arguments]    ${response}
    Should Be True    '${response[0]}' == 'FAIL'    Error: Failed to send POST request
    Should Contain    ${response[1]}    HTTPError: 400 Client Error: BAD REQUEST    Error: Unexpected error message














