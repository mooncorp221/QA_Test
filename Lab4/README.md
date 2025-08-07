# Lab 4 – Automatisation des tests sur l'application mobile looma.apk

Ce projet consiste à automatiser des scénarios de test sur l'application mobile **looma.apk** en utilisant **Appium** et **Robot Framework**.

## Objectif

* Tester les fonctionnalités suivantes :

  * Authentification utilisateur
  * Création de produit
  * Affichage d'un produit ajouté (ex. : "Rain Jacket Women Windbreaker")

## Architecture du projet

```
Lab4/
├── pageobject/
│   ├── locator.py             # Tous les sélecteurs (sans xpath pour l'innovation)
│   └── variables.py           # Paramètres d'exécution Appium
├── resources/
│   └── looma_keywords.robot   # Fichier des mots-clés personnalisés
├── testcases/
│   └── looma_test.robot       # Scénario de test d'ouverture et login
├── results/                  # Rapports de test générés
```

## Technologies

* **AppiumLibrary** pour Robot Framework
* Émulateur Android (Pixel 5 - Android 12)
* APK sous test : `looma.apk`

## Spécificités techniques

* Aucune utilisation de `xpath` pour les sélecteurs d'éléments (*prime d'innovation*)
* Utilisation de `UiSelector()` ou d'attributs comme `accessibility_id`

## Problème rencontré

Lors des tests d'authentification, tous les identifiants (y compris ceux fournis par [FakeStoreAPI](https://fakestoreapi.com/)) ont été refusés.

### Détails :

* L'application utilise l'API `https://fakestoreapi.com/auth/login` pour vérifier les identifiants.
* Aucun des comptes existants (ex : `mor_2314` / `83r5^_`) n'est reconnu.
* Les comptes créés via l'API `/users` ne sont pas utilisables pour se connecter via `/auth/login`.
* L'application bloque l'accès au formulaire produit en cas d'échec de connexion.

## Contournement

Un scénario alternatif a été proposé pour :

* Automatiser la saisie de champs login
* Valider la présence et la fermeture de la popup "Erreur de connexion"

Cela permet de tester l'interaction avec l'interface même si l'API ne valide aucun login.

## Exécution

```bash
robot testcases/looma_test.robot
```


---