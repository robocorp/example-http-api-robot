# ## Http API robot
#
# This simple robot fetches and logs the latest launch data from SpaceX API using RPA Framework.
# > You can find the full tutorial and instructions on [Robocorp's documentation site](https://robocorp.com/docs/development-guide/http/http-api-robot-tutorial).

*** Settings ***
Documentation     HTTP API robot. Retrieves data from SpaceX API. Demonstrates
...               how to use RPA.HTTP (get response, validate response status,
...               get response as JSON, access JSON properties, etc.).
Library           RPA.HTTP
Library           RPA.core.notebook

*** Variables ***
${SPACEX_API_LATEST_LAUNCHES_URL}=    https://api.spacexdata.com/v4/launches/latest

*** Keywords ***
Log latest launch
    ${launch}=    Get latest launch
    Log info    ${launch}

*** Keywords ***
Get latest launch
    ${response}=    GET    ${SPACEX_API_LATEST_LAUNCHES_URL}
    Request Should Be Successful
    Status Should Be    200
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
