import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/userController.dart';
import 'package:restaurant/size_config.dart';
import 'package:restaurant/screens/home_screen/components/DeliveryAddressSelector.dart';
import 'components/placeOrderNavigationBar.dart';
import 'components/summeryBottomSheetBody.dart';
import 'package:restaurant/screens/account_screen/addAdress.dart';

class SummeryBottomSheet extends StatelessWidget {
  const SummeryBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int promotion = 50;
    int deliveryFee = 40;
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenHeight(100)),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: SummeryBottomSheetBody(
          promotion: promotion,
          deliveryFee: deliveryFee,
        ),
        bottomNavigationBar: PlaceOrderNavigationBar(
          deliveryFee: deliveryFee,
          promotion: promotion,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var userController = Get.find<UserController>();
    return AppBar(
      backgroundColor: Color(0xFFeffef0),
      elevation: 0,
      leading: Obx(() {
        if (userController.deliveryAddress.value != null &&
            userController.addressCount != 0)
          return Icon(Icons.verified, color: Theme.of(context).primaryColor);
        else
          return Icon(Icons.add, color: Colors.red);
      }),
      title: Obx(() {
        if (userController.deliveryAddress.value != null &&
            userController.addressCount != 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                  "Delivery at ${userController.deliveryAddress.value.addressTag}")),
              Obx(() => Text(
                    "${userController.deliveryAddress.value.address}, ${userController.deliveryAddress.value.landMark}",
                    style: Theme.of(context).textTheme.subtitle1,
                  ))
            ],
          );
        }
        if (userController.addressCount != 0 &&
            userController.deliveryAddress.value == null) {
          return DeliveryAddressSelector();
        } else
          return InkWell(
              onTap: () {
                Get.to(AddAddressScreen());
              },
              child:
                  Text("Add Address", style: TextStyle(color: Colors.green)));
      }),
      actions: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 20),
          child: Obx(() {
            if (userController.addressCount != 0)
              return GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      title: "Select Delivery Address",
                      content: DeliveryAddressSelector());
                },
                child: Text(
                  "Change",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.redAccent),
                ),
              );
            else
              return Text(
                "Add",
                style: TextStyle(color: Colors.green),
              );
          }),
        )
      ],
    );
  }
}
