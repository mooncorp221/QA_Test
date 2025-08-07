*** Settings ***
Resource    ../resources/mongo_keywords.robot
Suite Setup    Create Product In MongoDB

*** Test Cases ***

# ─── CREATE ──────────────────────────────

Create Product - produit valide
    ${product}=    Create Dictionary
    ...    title=Thieboudienne
    ...    price=1200
    ...    description=Plat traditionnel
    ...    image=http://example.com/thieb.jpg
    ...    category=poisson
    ${id}=    Create Product    ${product}
    Log    Produit créé avec succès : ${id}
    Should Not Be Empty    ${id}

Create Product - intitule du produit manquant
    ${product}=    Create Dictionary
    ...    price=1200
    ...    category=poisson
    Run Keyword And Expect Error    *title*    Create Product    ${product}
    
Create Product - Champ price invalide
    ${invalid_product}=    Create Dictionary
    ...    title=Boulette
    ...    price=texte_invalide
    ...    category=viande
    Log Error From Keyword    Create Product    ${invalid_product}
# Log Error From Keyword
Create Product - prix invalide
    ${product}=    Create Dictionary
    ...    title=Thieb
    ...    price=invalid
    ...    category=poisson
    Run Keyword And Expect Error    *price*    Create Product    ${product}


# ─── READ ────────────────────────────────
Read Product - Valid ID
    Read Product From MongoDB    ${inserted_id}
    Log    Produit lu avec succès : ${inserted_id}
#id dois etre inserer manuellement dans la variable ${VaLID_PRODUCT_ID} pour les tests suivants
Read Product - identifiant valide
    ${product}=    Get Product By Id    ${inserted_id}
    Should Not Be Empty    ${product}
    Should Contain    ${product}    title


Read Product - Format invalide du ObjectId
    Run Keyword And Expect Error    *    Get Product By Id    ${NON_OBJECTID}

Read Product - ObjectId inexistant
    ${result}=    Get Product By Id    ${INVALID_PRODUCT_ID}
    Should Be True    ${result} is None


# ─── UPDATE ──────────────────────────────

Update Product - le produit existe
    ${data}=    Create Dictionary    price=3000
    ${updated}=    Update Product    ${inserted_id}    ${data}
    Should Be True    ${updated}

Update Product - identifiant invalide
    ${data}=    Create Dictionary    price=3000
    Run Keyword And Expect Error    *    Update Product    ${NON_OBJECTID}    ${data}

Update Product - donnees manquantes
    ${data}=    Create Dictionary
    ${updated}=    Update Product    ${inserted_id}    ${data}
    Should Not Be True    ${updated}

# ─── DELETE ──────────────────────────────

Delete Product - Valid ID
    ${deleted}=    Delete Product    ${inserted_id}
    Should Be True    ${deleted}

Delete Product - Invalid ObjectId
    Run Keyword And Expect Error    *    Delete Product    ${NON_OBJECTID}

Delete Product - Nonexistent ObjectId
    ${deleted}=    Delete Product    ${INVALID_PRODUCT_ID}
    Should Not Be True    ${deleted}
