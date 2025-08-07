MONGODB_URI = "mongodb+srv://testuser:Vj5NhYZt9iW8MAVv@mongodbatlas.xrxh67k.mongodb.net/?retryWrites=true&w=majority&appName=Mongodbatlas"
DB_NAME = "Mongodbatlas"
COLLECTION = "products"
# Identifiants valides et non valides pour les tests
VALID_PRODUCT_ID = "6890b17765df1778a1804210"       # Remplacer par un ObjectId réel existant
INVALID_PRODUCT_ID = "64f936bc2ae6a8d6c0f4bab9"     # ObjectId au bon format mais inexistant
NON_OBJECTID = "1234"                               # Format invalide (trop court)

# Données valides
VALID_PRODUCT = {
    "title": "Yassa Poulet",
    "price": 2000,
    "description": "Plat à base d'oignons et de citron",
    "image": "http://example.com/yassa.jpg",
    "category": "viande"
}

# Données avec champs manquants
MISSING_FIELDS_PRODUCT = {
    "title": "",
    "price": "",
}

# Données avec format de prix invalide
INVALID_PRICE_PRODUCT = {
    "title": "Thiakry",
    "price": "abc",
    "description": "Dessert au lait caillé",
    "image": "http://example.com/thiakry.jpg",
    "category": "dessert"
}

# Données de mise à jour valides
VALID_UPDATE_DATA = {
    "price": 3000
}

# Données de mise à jour vides
EMPTY_UPDATE_DATA = {}
