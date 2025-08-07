*** Settings ***
Library           Collections
Library           RequestsLibrary
Library           OperatingSystem
Library           String
Library           SeleniumLibrary
Library           ../resources/mongo_helper.py
Variables         ../pageobject/mongodb_vars.py

*** Keywords ***

Create Product In MongoDB
    ${product}=    Create Dictionary
    ...    title=Yassa
    ...    price=1500
    ...    description=Plat traditionnel sénégalais
    ...    image=http://example.com/yassa.jpg
    ...    category=volaille
    ${inserted_id}=    Create Product    ${product}
    Set Suite Variable    ${inserted_id}
    Should Not Be Empty    ${inserted_id}
    Log    Produit inséré avec succès : ${inserted_id}

Read Product From MongoDB
    [Arguments]    ${inserted_id}
    ${product}=    Get Product By Id    ${inserted_id}
    Should Not Be Empty    ${product}
    Log Dictionary    ${product}


Update Product In MongoDB
    [Arguments]    ${inserted_id}
    ${update_data}=    Create Dictionary    price=1800
    ${updated_count}=    Update Product    ${inserted_id}    ${update_data}
    Should Be Equal As Integers    ${updated_count}    1
    Log    Produit mis à jour avec succès

Delete Product From MongoDB
    [Arguments]    ${inserted_id}
    ${deleted_count}=    Delete Product    ${inserted_id}
    Should Be Equal As Integers    ${deleted_count}    1
    Log    Produit supprimé avec succès

Log Error From Keyword
    [Arguments]    ${keyword}    @{args}
    Run Keyword And Ignore Error    ${keyword}    @{args}
    ${status}    ${message}=    Run Keyword And Ignore Error    ${keyword}    @{args}
    Run Keyword If    '${status}' == 'FAIL'    Log    ${message}    level=ERROR
