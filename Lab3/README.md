# Lab3 - Test Automatisé eBay Fulfillment API

Ce projet contient les tests automatisés pour l'API eBay Fulfillment en utilisant Robot Framework et RequestsLibrary.

## Objectif

La startup souhaite s'interfacer avec eBay pour enrichir son catalogue produit.

Votre objectif est de tester l'intégration avec l'API Fulfillment d'eBay :
https://developer.ebay.com/api-docs/sell/fulfillment/resources/methods

Pour cela, créez :
• Un scénario passant et
• Un scénario non passant
pour les opérations suivantes :
• createShippingFulfillment
• getShippingFulfillment
• getShippingFulfillments

## PROJET TERMINÉ - 6 TESTS IMPLÉMENTÉS

```
Lab3/
├── pageobject/
│   └── variables.py      # Configuration complète : endpoints, données de test et payloads JSON
├── ressources/
│   └── lab3.robot        # Keywords réutilisables pour les tests API
├── testcases/
│   └── lab3.robot        # 6 cas de test pour l'API eBay Fulfillment
└── README.md            # Documentation complète du projet
```

## Configuration Requise

### Prérequis

- Python 3.8+
- Robot Framework
- RequestsLibrary

### Installation des Dépendances

```bash
pip install robotframework
pip install robotframework-requests
```

### Configuration de l'Authentification eBay

1. **Obtenir un token OAuth eBay** :

   - Créer un compte développeur sur [eBay Developers Program](https://developer.ebay.com/)
   - Générer les clés API (Client ID, Client Secret)
   - Obtenir un token OAuth pour l'environnement Sandbox

2. **Configurer le token** :
   - Remplacer `ACCESS_TOKEN = ""` dans `pageobject/variables.py`
   - Utiliser l'URL Sandbox : `https://api.sandbox.ebay.com`

## Scénarios de Test Implémentés

### CREATE SHIPPING FULFILLMENT

- **TC_3001** : ✅ Scénario passant - Création avec données valides (201)
- **TC_3002** : ❌ Scénario non passant - Payload invalide (400)

### GET SHIPPING FULFILLMENT

- **TC_3003** : ✅ Scénario passant - Récupération avec IDs valides (200)
- **TC_3004** : ❌ Scénario non passant - Order ID invalide (404)

### GET SHIPPING FULFILLMENTS

- **TC_3005** : ✅ Scénario passant - Liste avec Order ID valide (200)
- **TC_3006** : ❌ Scénario non passant - Order ID invalide (404)

## Exécution des Tests

### Tous les tests

```bash
cd Lab3
robot testcases/lab3.robot
```

### Tests par catégorie

```bash
# Tests de création
robot --include create testcases/lab3.robot

# Tests de récupération
robot --include get testcases/lab3.robot

# Tests positifs uniquement
robot --include positive testcases/lab3.robot

# Tests négatifs uniquement
robot --include negative testcases/lab3.robot
```

### Test spécifique

```bash
robot --include TC_3001 testcases/lab3.robot
```

## API eBay Fulfillment

### Endpoints testés

- **POST** `/sell/fulfillment/v1/order/{orderId}/shipping_fulfillment`
- **GET** `/sell/fulfillment/v1/order/{orderId}/shipping_fulfillment/{fulfillmentId}`
- **GET** `/sell/fulfillment/v1/order/{orderId}/shipping_fulfillment`

### Codes de réponse

- **201** : Fulfillment créé avec succès
- **200** : Récupération réussie
- **400** : Données invalides
- **404** : Ressource non trouvée

## Structure des Données

### Payload valide (dans variables.py)

```python
CREATE_FULFILLMENT_VALID_PAYLOAD = {
    "lineItems": [
        {
            "lineItemId": "6012345678901234567",
            "quantity": 1
        }
    ],
    "shippedDate": "2024-08-01T14:30:00.000Z",
    "shippingCarrierCode": "UPS",
    "trackingNumber": "1Z999AA1234567890"
}
```

### Payload invalide (dans variables.py)

```python
CREATE_FULFILLMENT_INVALID_PAYLOAD = {
    "lineItems": [{"lineItemId": "invalid-order-id", "quantity": 1}],
    "shippedDate": "2024-08-01T14:30:00.000Z",
    "shippingCarrierCode": "UPS",
    "trackingNumber": "1Z999AA1234567890"
}
```

## Résultats des Tests

Les résultats sont générés dans :

- `log.html` : Journal détaillé d'exécution
- `report.html` : Rapport de synthèse
- `output.xml` : Données XML pour intégration CI/CD
