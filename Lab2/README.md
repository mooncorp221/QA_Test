# Lab2 - Test Automatisé Selenium UI

Ce projet contient les tests automatisés d'interface utilisateur pour une application CRM en utilisant Robot Framework et SeleniumLibrary.

## Structure du Projet
```
Lab2/
├── pageobject/
│   ├── locators.py       # Sélecteurs CSS/XPath pour tous les éléments UI
│   └── variables.py      # Configuration : URLs, données de test, timeouts
├── ressources/
│   └── lab2.robot        # Keywords réutilisables pour les actions UI
├── testcases/
│   └── lab2.robot        # 8 cas de test pour l'interface CRM
├── results/
│   ├── log.html         # Journal détaillé d'exécution
│   ├── report.html      # Rapport de synthèse
│   └── output.xml       # Données XML pour intégration CI/CD
└── README.md            # Documentation complète du projet
```

## Configuration Requise

### Prérequis

- Python 3.8+
- Robot Framework
- SeleniumLibrary

### Installation des Dépendances

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
```

## Scénarios de Test Implémentés

### HOME PAGE (1 test)

- **TC_1001** : ✅ Page d'accueil se charge correctement (Smoke Test)

### AUTHENTIFICATION (4 tests)

- **TC_1002** : ✅ Connexion réussie avec identifiants valides (Smoke Test)
- **TC_1003** : ❌ Connexion échoue avec identifiants manquants (Test Fonctionnel)
- **TC_1004** : ✅ Case "Se souvenir de moi" persiste l'email (Test Fonctionnel)
- **TC_1005** : ✅ Déconnexion utilisateur (Test Fonctionnel)

### GESTION CLIENTS (3 tests)

- **TC_1006** : ✅ Page clients affiche plusieurs enregistrements (Smoke Test)
- **TC_1007** : ✅ Ajout de nouveau client (Smoke Test)
- **TC_1008** : ✅ Annulation de l'ajout client (Test Fonctionnel)

## Exécution des Tests

### Tous les tests

```bash
cd Lab2
robot testcases/lab2.robot
```

### Tests par fonctionnalité

```bash
# Tests de connexion uniquement
robot --include Login testcases/lab2.robot

# Tests Smoke uniquement
robot --include Smoke testcases/lab2.robot

# Tests fonctionnels uniquement
robot --include Functional testcases/lab2.robot
```

## Application CRM Testée

**Application testée** : [CRM Automation Playground](https://automationplayground.com/crm/index.html)

### Pages Couvertes

- **Page d'accueil** : `index.html` - Point d'entrée de l'application
- **Page de connexion** : `login.html` - Authentification utilisateur
- **Page clients** : `customers.html` - Liste et gestion des clients
- **Page ajout client** : `add-customer.html` - Formulaire de création
- **Page déconnexion** : `sign-out.html` - Confirmation de déconnexion

### Fonctionnalités Testées

- Navigation entre pages
- Validation de formulaires
- Persistance des données (Remember Me)
- CRUD clients (Create, Read)
- Gestion des erreurs d'authentification

## Configuration de Test

### Identifiants de Test

```python
VALID_EMAIL = "admin@crmapp.com"
VALID_PASSWORD = "password123"
```

### Données Client de Test

```python
CUSTOMER_EMAIL = "test@example.com"
CUSTOMER_FIRST_NAME = "John"
CUSTOMER_LAST_NAME = "Doe"
CUSTOMER_CITY = "New York"
CUSTOMER_STATE = "NY"
```

### Paramètres Navigateur

```python
BROWSER = "chrome"          # Navigateur par défaut
TIMEOUT = 3                 # Timeout d'attente (secondes)
SPEED = 0.5                # Vitesse d'exécution (secondes entre actions)
```

## Page Object Model

### Structure des Locators (locators.py)

```python
# Exemples de sélecteurs utilisés
SIGN_IN_LINK = "xpath=//a[@class='nav-link' and @href='login.html']"
EMAIL_INPUT = "id=email-id"
CUSTOMERS_TABLE_ROWS = "xpath=//table[@id='customers']/tbody/tr"
NEW_CUSTOMER_BUTTON = "id=new-customer"
```

### Keywords Réutilisables (ressources/lab2.robot)

- **Navigation** : `Navigate To Home Page`, `Click Login Link`
- **Authentification** : `Type Valid Login Credentials`, `Click Submit Button`
- **Gestion Clients** : `Examine Customers Grid`, `Click New Customer Button`
- **Formulaires** : `Type Customer Email`, `Select Customer State`

## Résultats des Tests

Les résultats sont générés dans le dossier `results/` :

- **`log.html`** : Journal détaillé avec captures d'écran en cas d'échec
- **`report.html`** : Rapport de synthèse avec statistiques
- **`output.xml`** : Données XML pour intégration CI/CD
