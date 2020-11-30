import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String landMark;
  GeoPoint geoPoint;
  String addressTag;
  String geoLocation;

  AddressModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.landMark,
    this.geoPoint,
    this.addressTag,
    this.geoLocation,
  });

  AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.firstName = snapshot["firstName"];
    this.lastName = snapshot["lastName"];
    this.phoneNumber = snapshot["phoneNumber"];
    this.address = snapshot["address"];
    this.landMark = snapshot["landMark"];
    this.geoPoint = snapshot["geoPoint"];
    this.addressTag = snapshot["addressTag"];
    this.geoLocation = snapshot["geoLocation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["firstName"] = this.firstName;
    data["lastName"] = this.lastName;
    data["phoneNumber"] = this.phoneNumber;
    data["address"] = this.address;
    data["landMark"] = this.landMark;
    data["geoPoint"] = this.geoPoint;
    data["addressTag"] = this.addressTag;
    data["geoLocation"] = this.geoLocation;
    return data;
  }
}
