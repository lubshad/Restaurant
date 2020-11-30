import 'package:cloud_firestore/cloud_firestore.dart';

class Drinks {
  String id;
  String title;
  String image;
  int price;
  String description;

  Drinks({this.title, this.description, this.price, this.image});

  Drinks.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.title = snapshot["title"];
    this.description = snapshot["description"];
    this.image = snapshot["image"];
    this.price = snapshot["price"];
  }
}
