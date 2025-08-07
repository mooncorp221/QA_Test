from pymongo import MongoClient
from bson import ObjectId, errors as bson_errors

def connect_to_db():
    uri = "mongodb+srv://testuser:Vj5NhYZt9iW8MAVv@mongodbatlas.xrxh67k.mongodb.net/?retryWrites=true&w=majority&appName=Mongodbatlas"
    client = MongoClient(uri)
    db = client["Mongodbatlas"]
    return db

def create_product(product):
    if not isinstance(product, dict):
        raise ValueError("Le produit doit être un dictionnaire.")
    
    required_fields = ["title", "price", "category"]
    for field in required_fields:
        if field not in product:
            raise ValueError(f"Champ requis manquant: {field}")
    
    try:
        product["price"] = float(product["price"])
    except (ValueError, TypeError):
        raise ValueError("Le champ 'price' doit être un nombre.")
    
    db = connect_to_db()
    collection = db["products"]
    result = collection.insert_one(product)
    return str(result.inserted_id)




def get_product_by_id(product_id):
    try:
        object_id = ObjectId(product_id)
    except bson_errors.InvalidId:
        raise ValueError("Format d'identifiant invalide.")
    
    db = connect_to_db()
    collection = db["products"]
    result = collection.find_one({"_id": object_id})
    return result


def update_product(product_id, update_data):
    db = connect_to_db()
    collection = db["products"]
    result = collection.update_one({"_id": ObjectId(product_id)}, {"$set": update_data})
    return result.modified_count

def delete_product(product_id):
    db = connect_to_db()
    collection = db["products"]
    result = collection.delete_one({"_id": ObjectId(product_id)})
    return result.deleted_count
