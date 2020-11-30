import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/authController.dart';
import 'package:restaurant/models/addressModel.dart';
import 'package:restaurant/models/cartItem.dart';
import 'package:restaurant/models/deals_item_model.dart';
import 'package:restaurant/models/desserModel.dart';
import 'package:restaurant/models/drinks.dart';
import 'package:restaurant/models/menuItem.dart';
import 'package:restaurant/models/orderModel.dart';
import 'package:restaurant/models/sideModel.dart';
import 'dart:io';

class DatabaseService {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  User user = Get.find<AuthController>().user;
  FirebaseMessaging fcm = FirebaseMessaging();

  void subscribeToRestaurant() {
    fcm.subscribeToTopic("Restaurant");
  }

  void saveDeviceToken() async {
    String fcmToken = await fcm.getToken();
    instance
        .collection("Users")
        .doc(user.uid)
        .collection("FcmToken")
        .doc(user.uid)
        .set({
      "token": fcmToken,
      "time": FieldValue.serverTimestamp(),
      "platform": Platform.operatingSystem,
    });
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  void onMessageRecived() {
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message["notification"]);
        Get.snackbar(
            message["notification"]["title"], message["notification"]["body"]);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print(message["notification"]);
        Get.snackbar(
            message["notification"]["title"], message["notification"]["body"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print(message["notification"]);
        Get.snackbar(
            message["notification"]["title"], message["notification"]["body"]);
      },
    );
  }

  // deals stream
  Stream<List<DealItem>> dealStream() {
    return instance.collection("Deals").snapshots().map((dealList) {
      List<DealItem> _dealList = List();
      dealList.docs.forEach((deal) {
        if (deal.exists) {
          _dealList.add(DealItem.fromDocumentSnapshot(deal));
        }
      });
      return _dealList;
    });
  }

  // menu stream
  Stream<List<MenuItem>> menuStream() {
    return instance.collection("Menu").snapshots().map((menuList) {
      List<MenuItem> _menuList = List();
      menuList.docs.forEach((menuItem) {
        if (menuItem.exists)
          _menuList.add(MenuItem.fromDocumentSnapshot(menuItem));
      });
      return _menuList;
    });
  }

  // sides Stream
  Stream<List<SideItem>> sideStream() {
    return instance.collection("Sides").snapshots().map((sides) {
      List<SideItem> _sidesList = List();
      sides.docs.forEach((side) {
        if (side.exists) _sidesList.add(SideItem.fromDocumentSnapshot(side));
      });
      return _sidesList;
    });
  }

  // dessert Stream
  Stream<List<DessertItem>> dessertStream() {
    return instance.collection("Desserts").snapshots().map((desserts) {
      List<DessertItem> _dessertList = List();
      desserts.docs.forEach((dessert) {
        if (dessert.exists)
          _dessertList.add(DessertItem.fromDocumentSnapshot(dessert));
      });
      return _dessertList;
    });
  }

  // drinks Stream
  Stream<List<Drinks>> drinksStream() {
    return instance.collection("Drinks").snapshots().map((drinks) {
      List<Drinks> _drinksList = List();
      drinks.docs.forEach((drink) {
        if (drink.exists) _drinksList.add(Drinks.fromDocumentSnapshot(drink));
      });
      return _drinksList;
    });
  }

  // live order stream
  Stream<List<OrderModel>> liveOrderStream() {
    return instance
        .collection("Users")
        .doc(user.uid)
        .collection("LiveOrders")
        .snapshots()
        .map((orders) {
      List<OrderModel> _orderList = List();
      orders.docs.forEach((order) {
        if (order.exists)
          _orderList.add(OrderModel.fromDocumentSnapshot(order));
      });
      return _orderList;
    });
  }

  Future<void> addAddress(AddressModel addressModel) async {
    await instance
        .collection("Users")
        .doc(user.uid)
        .collection("Address")
        .add(addressModel.toJson());
    setDeliveryAddress(addressModel);
  }

  void deleteAddress(String addressId) async {
    await instance
        .collection("Users")
        .doc(user.uid)
        .collection("Address")
        .doc(addressId)
        .delete();
  }

  void setDeliveryAddress(AddressModel addressModel) async {
    await instance
        .collection("Users")
        .doc(user.uid)
        .collection("DeliveryAddress")
        .doc(user.uid)
        .set(addressModel.toJson());
  }

  void updateAddress(AddressModel addressModel) async {
    await instance
        .collection("Users")
        .doc(user.uid)
        .collection("Address")
        .doc(addressModel.id)
        .update(addressModel.toJson());
  }

  Stream<List<AddressModel>> getAddressStream() {
    return instance
        .collection("Users")
        .doc(user.uid)
        .collection("Address")
        .snapshots()
        .map((addresses) {
      List<AddressModel> addressModel = List();
      addresses.docs.forEach((address) {
        if (address.exists)
          addressModel.add(AddressModel.fromDocumentSnapshot(address));
      });
      return addressModel;
    });
  }

  Stream<AddressModel> getDeliveryAddress() {
    return instance
        .collection("Users")
        .doc(user.uid)
        .collection("DeliveryAddress")
        .doc(user.uid)
        .snapshots()
        .map((deliveryAddress) {
      if (deliveryAddress.exists)
        return AddressModel.fromDocumentSnapshot(deliveryAddress);
      else
        return null;
    });
  }

  void updateDeliveryAddress(AddressModel addressModel) {
    var doc = instance
        .collection("Users")
        .doc(user.uid)
        .collection("DeliveryAddress")
        .doc(user.uid);
    if (doc != null)
      doc.update(addressModel.toJson());
    else
      return null;
  }

  void setProfilePicture(String url) {
    instance.collection("Users").doc(user.uid).update({"profilePicture": url});
  }

  Stream<List<CartItemModel>> cartItemStream() {
    return instance
        .collection("Users")
        .doc(user.uid)
        .collection("CartItems")
        .snapshots()
        .map((items) {
      List<CartItemModel> _listCartItems = List();
      items.docs.forEach((item) {
        if (item.exists)
          _listCartItems.add(CartItemModel.fromDocumentSnapshot(item));
      });
      return _listCartItems;
    });
  }
}
