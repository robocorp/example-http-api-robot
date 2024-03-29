*** Settings ***
Documentation       HTTP API robot. Retrieves data from SpaceX API. Demonstrates
...                 how to use RPA.HTTP (get response, validate response status,
...                 get response as JSON, access JSON properties, etc.).

Library             RPA.HTTP


*** Variables ***
${SPACEX_API_LATEST_LAUNCHES_URL}=      https://api.spacexdata.com/v4/launches/latest


*** Tasks ***
Log latest launch info
    Log latest launch


*** Keywords ***
Log latest launch
    ${launch}=    Get latest launch
    Log info    ${launch}

Get latest launch
    ${response}=    GET    ${SPACEX_API_LATEST_LAUNCHES_URL}
    Request Should Be Successful
    Status Should Be    200
    RETURN    ${response}

Log info
    [Arguments]    ${response}
    ${launch}=    Set Variable    ${response.json()}
    Log    ${launch}
    Log    ${launch["name"]}
    Log    ${launch["links"]["reddit"]["campaign"]}
