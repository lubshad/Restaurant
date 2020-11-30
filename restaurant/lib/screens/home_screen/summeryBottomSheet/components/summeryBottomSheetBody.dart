import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/cartController.dart';
import 'package:restaurant/screens/home_screen/summeryBottomSheet/components/cartItemExpansionTile.dart';
import 'package:restaurant/size_config.dart';

class SummeryBottomSheetBody extends StatelessWidget {
  const SummeryBottomSheetBody({
    Key key,
    this.deliveryFee,
    this.promotion,
  }) : super(key: key);
  final int deliveryFee;
  final int promotion;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
            vertical: getProportionateScreenHeight(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Your Orders", style: Theme.of(context).textTheme.headline6),
              Text(
                "Add More",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.lightGreen,
                    ),
              )
            ],
          ),
        ),
        Container(
          child: Expanded(
            child: GetX<CartController>(
              init: Get.find<CartController>(),
              builder: (cartController) {
                return ListView.separated(
                  itemBuilder: (context, index) => CartItemExpansionTile(
                    cartItem: cartController.cartItemsList[index],
                  ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: cartController.count,
                );
              },
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
              vertical: getProportionateScreenHeight(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 18),
              ),
              GetX<CartController>(
                init: Get.find<CartController>(),
                builder: (cartController) {
                  return Text(
                    "₹${cartController.totalPrice}",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 18),
                  );
                },
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
              vertical: getProportionateScreenHeight(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Promotion",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 18),
              ),
              Text(
                "₹$promotion",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 18),
              )
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
              vertical: getProportionateScreenHeight(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Fee",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 18),
              ),
              Text(
                "₹$deliveryFee",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 18),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
