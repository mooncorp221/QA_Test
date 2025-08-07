*** Settings ***
Library           AppiumLibrary


Resource         ../resources/looma_keywords.robot


Suite Setup    Run Keyword    Open App


*** Test Cases ***
Ouvrir l'application et se connecter
    [Tags]     "init"
    Saisir username
    Saisir password
    Se connecter

Test Échec de Connexion avec identifiants invalides
    Saisir username
    Saisir password
    Se connecter
    Wait Until Page Contains Element    accessibility_id=OK
    Page Should Contain Text    Erreur de connexion
    Click Element    accessibility_id=OK
    Log    L’erreur d’authentification a été correctement affichée.
