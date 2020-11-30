import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/models/addressModel.dart';
import 'package:restaurant/models/cartItem.dart';

enum OrderStatus {
  OrderPlaced,
  OrderCancelled,
  OrderAccepted,
  Preparing,
  OnTheWay,
  Completed,
}

statusToString(OrderStatus status) {
  switch (status) {
    case OrderStatus.OrderPlaced:
      return "Order Placed";
      break;
    case OrderStatus.OrderCancelled:
      return "Order Cancelled";
      break;
    case OrderStatus.OrderAccepted:
      return "Order Accepted";
      break;
    case OrderStatus.Preparing:
      return "Preparing";
      break;
    case OrderStatus.OnTheWay:
      return "On The Way";
      break;
    case OrderStatus.Completed:
      return "Completed";
      break;
  }
}

stringToStatus(String status) {
  switch (status) {
    case "Completed":
      return OrderStatus.Completed;
      break;
    case "On The Way":
      return OrderStatus.OnTheWay;
      break;
    case "Preparing":
      return OrderStatus.Preparing;
      break;
    case "Order Cancelled":
      return OrderStatus.OrderCancelled;
      break;
    case "Order Accepted":
      return OrderStatus.OrderAccepted;
      break;
    case "Order Placed":
      return OrderStatus.OrderPlaced;
      break;
  }
}

class OrderModel {
  String id;
  int totalPrice;
  String restaurentName;
  List items;
  int subTotal;
  int promotion;
  int deliveryFee;
  AddressModel deliveryAddress;
  Timestamp time;
  OrderStatus orderStatus;
  String prefferedDateTime;
  String customerId;

  OrderModel({
    this.id,
    this.totalPrice,
    this.restaurentName,
    this.items,
    this.deliveryFee,
    this.promotion,
    this.subTotal,
    this.deliveryAddress,
    this.time,
    this.orderStatus,
    this.prefferedDateTime,
    this.customerId,
  });

  OrderModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.totalPrice = snapshot["totalPrice"];
    this.restaurentName = snapshot["restaurentName"];
    this.items = snapshot["items"];
    this.deliveryFee = snapshot["deliveryFee"];
    this.promotion = snapshot["promotion"];
    this.subTotal = snapshot["subTotal"];
    this.deliveryAddress = AddressModel(
      firstName: snapshot["deliveryAddress"]["firstName"],
      landMark: snapshot["deliveryAddress"]["landMark"],
      lastName: snapshot["deliveryAddress"]["lastName"],
      phoneNumber: snapshot["deliveryAddress"]["phoneNumber"],
      address: snapshot["deliveryAddress"]["address"],
      geoLocation: snapshot["deliveryAddress"]["geoLocation"],
      geoPoint: snapshot["deliveryAddress"]["geoPoint"],
      addressTag: snapshot["deliveryAddress"]["addressTag"],
    );
    this.time = snapshot["time"];
    this.orderStatus = stringToStatus(snapshot["orderStatus"]);
    this.prefferedDateTime = snapshot["prefferedDateTime"];
    this.customerId = snapshot["customerId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["restaurentName"] = this.restaurentName;
    data["totalPrice"] = this.totalPrice;
    data["items"] = this
        .items
        .map((e) => CartItemModel(
                id: e.id,
                description: e.description,
                image: e.image,
                includedItems: e.includedItems,
                price: e.price,
                title: e.title,
                drink: e.drink,
                quantity: e.quantity)
            .toJson())
        .toList();
    data["deliveryFee"] = this.deliveryFee;
    data["promotion"] = this.promotion;
    data["subTotal"] = this.subTotal;
    data["deliveryAddress"] = this.deliveryAddress.toJson();
    data["time"] = DateTime.now();
    data["orderStatus"] = statusToString(OrderStatus.OrderPlaced);
    data["prefferedDateTime"] = this.prefferedDateTime;
    data["customerId"] = this.customerId;
    return data;
  }
}
