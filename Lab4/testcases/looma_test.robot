*** Settings ***
Library    AppiumLibrary

Variables    ../pageobject/variables.py
Variables    ../pageobject/locator.py

*** Keywords ***
Open App
    [Documentation]    Open the app with the specified remote URL and capabilities.
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    automationName=${AUTOMATION_NAME}
Saisir username
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${USERNAME}
    Input Text    ${USERNAME}    ${username}

Saisir password
    [Arguments]    ${password}
    Wait Until Element Is Visible    ${PASSWORD}
    Input Text    ${PASSWORD}    ${password}


Se connecter
    [Documentation]    Click the login button to submit the form.
    Wait Until Element Is Visible    ${LOGIN_BUTTON}
    Click Element    ${LOGIN_BUTTON}
    