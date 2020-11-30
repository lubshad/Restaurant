import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
  String title;
  List includedItems;
  String image;
  int price;
  String id;

  MenuItem({
    this.id,
    this.title,
    this.includedItems,
    this.image,
    this.price,
  });

  MenuItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.title = snapshot["title"];
    this.includedItems = snapshot["includedItems"];
    this.image = snapshot["image"];
    this.price = snapshot["price"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = this.title;
    data["includedItems"] = this.includedItems;
    data["image"] = this.image;
    data["price"] = this.price;
    return data;
  }
}
