*** Settings ***
Library           AppiumLibrary

Variables        ../pageobject/variables.py
Resource         ../resources/looma_keywords.robot


Suite Setup    Run Keyword    Open App


*** Test Cases ***
Ouvrir l'application et se connecter
    [Tags]     "init"
    Saisir username
    Saisir password
    Se connecter