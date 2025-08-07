# Projet : Tests automatisés MongoDB avec Robot Framework

Ce projet vise à automatiser les opérations CRUD (Create, Read, Update, Delete) sur une base MongoDB hébergée sur MongoDB Atlas à l'aide de **Robot Framework** et de la bibliothèque **pymongo**.

##  Objectifs

* Tester l'insertion, la lecture, la mise à jour et la suppression de documents dans MongoDB.
* Simuler des cas valides et des cas d'erreurs.
* Garantir la robustesse des opérations en base.

##  Structure du projet

```
project-root/
├── resources/
│   ├── mongo_helper.py              # Fonctions Python utilisant pymongo
│   └── mongo_keywords.robot         # Keywords Robot Framework basés sur mongo_helper
├── testcases/
│   └── mongo_testcases.robot        # Cas de test CRUD
├── variables/
│   └── mongodb_vars.py              # URI, noms de collections, IDs de test
├── results/                         # Rapports d'exécution (log.html, report.html)
```

##  Prérequis

* Python 3.x
* Robot Framework
* pymongo
* MongoDB Atlas (avec URI valide)

### Installation des dépendances

```bash
pip install robotframework pymongo
```

## ⚙️ Lancement des tests

Depuis la racine du projet :

```bash
robot testcases/mongo_testcases.robot
```

Les rapports seront générés dans le dossier `results/` :

* `log.html`
* `report.html`

## Variables utiles (`mongodb_vars.py`)

```python
MONGODB_URI = "mongodb+srv://..."
DB_NAME = "Mongodbatlas"
COLLECTION = "products"
VALID_PRODUCT_ID = "..."         # ObjectId réel
INVALID_PRODUCT_ID = "..."       # ObjectId correct mais inexistant
NON_OBJECTID = "1234"            # Format invalide
```

## Exemple de test - Création de produit

```robot
Create Product - produit valide
    ${product}=    Create Dictionary
    ...    title=Thieboudienne
    ...    price=1200
    ...    category=poisson
    ${id}=    Create Product    ${product}
    Should Not Be Empty    ${id}
```
