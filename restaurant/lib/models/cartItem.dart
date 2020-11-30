import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  String title;
  String drink;
  List includedItems;
  String image;
  int price;
  String id;
  String description;
  int quantity;
  String size;

  CartItemModel({
    this.id,
    this.description,
    this.image,
    this.includedItems,
    this.price,
    this.title,
    this.drink,
    this.quantity,
    this.size,
  });

  CartItemModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.description = snapshot["description"];
    this.image = snapshot["image"];
    this.includedItems = snapshot["includedItems"];
    this.price = snapshot["price"];
    this.title = snapshot["title"];
    this.drink = snapshot["drink"];
    this.quantity = snapshot["quantity"];
    this.size = snapshot["size"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["description"] = this.description;
    data["image"] = this.image;
    data["includedItems"] = this.includedItems;
    data["price"] = this.price;
    data["title"] = this.title;
    data["drink"] = this.drink;
    data["quantity"] = this.quantity;
    data["size"] = this.size;
    return data;
  }
}
