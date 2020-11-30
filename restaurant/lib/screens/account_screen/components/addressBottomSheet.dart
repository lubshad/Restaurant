import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlacePicker(
        useCurrentLocation: true,
        apiKey: "AIzaSyDSFplTI7kE86HePT7jpOfJ4xfHdB0NFX8",
        initialPosition: LatLng(0, 0),
        onPlacePicked: (location) {
          GeoPoint geoPoint = GeoPoint(
              location.geometry.location.lat, location.geometry.location.lng);
          String place = location.formattedAddress;
          Get.back(result: {
            "geoPoint": geoPoint,
            "place": place,
          });
        },
      ),
    );
  }
}
