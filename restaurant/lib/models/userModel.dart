import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String profilePicture;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profilePicture,
  });

  UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.email = snapshot["email"] ?? "loading";
    this.firstName = snapshot["firstName"] ?? "loading";
    this.lastName = snapshot["lastName"];
    this.phoneNumber = snapshot["phoneNumber"];
    this.profilePicture = snapshot["profilePicture"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["email"] = this.email;
    data["firstName"] = this.firstName;
    data["lastName"] = this.lastName;
    data["phoneNumber"] = this.phoneNumber;
    data["profilePicture"] = this.profilePicture;
    return data;
  }
}
