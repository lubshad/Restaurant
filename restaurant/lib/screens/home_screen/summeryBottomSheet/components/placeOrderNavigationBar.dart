import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/cartController.dart';
import 'package:restaurant/controllers/userController.dart';
import 'package:restaurant/models/orderModel.dart';
import 'package:restaurant/size_config.dart';
import 'package:restaurant/screens/account_screen/addAdress.dart';
import 'package:restaurant/screens/home_screen/components/DeliveryAddressSelector.dart';

class PlaceOrderNavigationBar extends StatelessWidget {
  const PlaceOrderNavigationBar({
    Key key,
    this.deliveryFee,
    this.promotion,
  }) : super(key: key);
  final int deliveryFee;
  final int promotion;

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var userController = Get.find<UserController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(10, 0),
          )
        ],
      ),
      height: getProportionateScreenHeight(65),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child:
                    Text("COD", style: Theme.of(context).textTheme.headline6),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  if (userController.deliveryAddress.value != null) {
                    OrderModel orderModel = OrderModel(
                      totalPrice:
                          cartController.totalPrice + deliveryFee - promotion,
                      restaurentName: "Crispy Bay",
                      items: cartController.cartItemsList,
                      deliveryFee: deliveryFee,
                      promotion: promotion,
                      subTotal: cartController.totalPrice,
                      deliveryAddress: userController.deliveryAddress.value,
                      prefferedDateTime: userController.prefferedDateTime.value,
                      customerId: userController.userModel.id,
                    );
                    await cartController.placeOrder(orderModel);
                    cartController.cartItemsList.forEach((item) {
                      cartController.deleteItem(item.id);
                    });
                    Get.back();
                  }
                  if (userController.addressCount != 0 &&
                      userController.deliveryAddress.value == null) {
                    Get.defaultDialog(
                        title: "Select Delivery Address",
                        content: DeliveryAddressSelector());
                  }
                  if (userController.addressCount == 0)
                    Get.defaultDialog(
                        content: InkWell(
                            onTap: () {
                              Get.back();
                              Get.to(AddAddressScreen());
                            },
                            child: Text("Add Address",
                                style: TextStyle(color: Colors.green))));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white),
                          ),
                          GetX<CartController>(
                            init: Get.find<CartController>(),
                            builder: (cartController) {
                              return Text(
                                "₹${cartController.totalPrice - promotion + deliveryFee}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              );
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Place Order",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
