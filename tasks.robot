# ## Http API robot
#
# This simple robot fetches and logs the latest launch data from SpaceX API using RPA Framework.
# > You can find the full tutorial and instructions on [Robocorp's documentation site](https://robocorp.com/docs/development-howtos/http/http-api-robot-tutorial).

*** Settings ***
Documentation     HTTP API robot. Retrieves data from SpaceX API. Demonstrates
...               how to use RPA.HTTP (create session, get response, validate
...               response status, get response as JSON, access JSON
...               properties, etc.).
Library           RPA.HTTP
Library           RPA.core.notebook
Suite Setup       Setup
Suite Teardown    Teardown

*** Variables ***
${SPACEX_API_BASE_URL}=    https://api.spacexdata.com/v4
${SPACEX_API_LATEST_LAUNCHES}=    /launches/latest

*** Keywords ***
Setup
    Create Session    spacex    ${SPACEX_API_BASE_URL}    verify=True

*** Keywords ***
Teardown
    Delete All Sessions

*** Keywords ***
Log latest launch
    ${launch}=    Get latest launch
    Log info    ${launch}

*** Keywords ***
Get latest launch
    ${response}=    GET On Session    spacex    ${SPACEX_API_LATEST_LAUNCHES}
    Request Should Be Successful    ${response}
    Status Should Be    200    ${response}
    [Return]    ${response}

*** Keywords ***
Log info
    [Arguments]    ${response}
    ${launch}=    Set Variable    ${response.json()}
    Notebook Print    ${launch}
    Log    ${launch}
    Notebook Print    ${launch["name"]}
    Log    ${launch["name"]}
    Notebook Print    ${launch["links"]["reddit"]["campaign"]}
    Log    ${launch["links"]["reddit"]["campaign"]}

*** Tasks ***
Log latest launch info
    Log latest launch
