*** Settings ***
Library    AppiumLibrary

Variables    ../pageobject/variables.py
Variables    ../pageobject/locator.py

*** Keywords ***

Open App
    [Documentation]    Open the app with the specified remote URL and capabilities.
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    automationName=${AUTOMATION_NAME}

Saisir username
    Wait Until Element Is Visible    ${USERNAME}    5
    Click Element    ${USERNAME}
    Input Text    ${USERNAME}    mouhamed221
    
Saisir password
    Wait Until Element Is Visible    ${PASSWORD}    5
    Click Element    ${PASSWORD}
    Input Password    ${PASSWORD}    pass1234


Se connecter
    [Documentation]    Click the login button to submit the form.
    Wait Until Element Is Visible    ${LOGIN_BUTTON}
    Click Element    ${LOGIN_BUTTON}
