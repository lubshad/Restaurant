import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/authController.dart';
import 'package:restaurant/models/cartItem.dart';
import 'package:restaurant/models/orderModel.dart';
import 'package:restaurant/services/database_service.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _cartItemsList.bindStream(DatabaseService().cartItemStream());
  }

  var user = Get.find<AuthController>().user;
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Rx<List<CartItemModel>> _cartItemsList = Rx<List<CartItemModel>>();

  List<CartItemModel> get cartItemsList => _cartItemsList.value;

  int get count => cartItemsList?.length ?? 0;

  int get totalPrice =>
      cartItemsList.fold(0, (sum, item) => sum + item.price * item.quantity);

  // add To Cart
  Future addToCart(Map<String, dynamic> item, String uid) async {
    await instance
        .collection("Users")
        .doc(uid)
        .collection("CartItems")
        .add(item);
  }

  Future increaseQuantity(String itemId) async {
    await instance
        .collection("Users")
        .doc(user.uid)
        .collection("CartItems")
        .doc(itemId)
        .update({"quantity": FieldValue.increment(1)});
  }

  Future decreaseQuantity(String itemId) async {
    await instance
        .collection("Users")
        .doc(user.uid)
        .collection("CartItems")
        .doc(itemId)
        .update(
      {"quantity": FieldValue.increment(-1)},
    );
  }

  Future deleteItem(String itemId) async {
    await instance
        .collection("Users")
        .doc(user.uid)
        .collection("CartItems")
        .doc(itemId)
        .delete();
  }

  Future placeOrder(OrderModel orderModel) async {
    var response =
        await instance.collection("LiveOrders").add(orderModel.toJson());
    await instance
        .collection("Users")
        .doc(user.uid)
        .collection("LiveOrders")
        .doc(response.id)
        .set(orderModel.toJson());
  }
}
