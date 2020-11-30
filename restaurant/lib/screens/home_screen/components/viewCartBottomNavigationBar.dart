import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/cartController.dart';
import 'package:restaurant/screens/home_screen/summeryBottomSheet/summeryBottomSheet.dart';

import '../../../size_config.dart';

class ViewCartBottomNavigationBar extends StatelessWidget {
  const ViewCartBottomNavigationBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    return Obx(
      () {
        return Visibility(
          visible: cartController.count == 0 ? false : true,
          child: InkWell(
            onTap: () {
              Get.bottomSheet(SummeryBottomSheet(), isScrollControlled: true);
            },
            child: Container(
              height: getProportionateScreenHeight(60),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View Cart",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                    GetX<CartController>(
                      init: Get.find<CartController>(),
                      builder: (cartController) {
                        return Text(
                          "Total: ₹${cartController.totalPrice}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
