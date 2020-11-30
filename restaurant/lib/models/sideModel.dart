import 'package:cloud_firestore/cloud_firestore.dart';

class SideItem {
  String title;
  String image;
  int price;
  String description;
  String id;

  SideItem({
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
  });

  SideItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.title = snapshot["title"];
    this.description = snapshot["description"];
    this.image = snapshot["image"];
    this.price = snapshot["price"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = this.title;
    data["description"] = this.description;
    data["image"] = this.image;
    data["price"] = this.price;
    return data;
  }
}
