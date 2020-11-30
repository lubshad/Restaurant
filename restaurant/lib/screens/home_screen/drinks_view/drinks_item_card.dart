import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/authController.dart';
import 'package:restaurant/controllers/cartController.dart';
import 'package:restaurant/models/cartItem.dart';
import 'package:restaurant/models/drinks.dart';
import 'package:shimmer/shimmer.dart';

import '../../../size_config.dart';

class DrinksItemCard extends StatelessWidget {
  final Drinks drinks;

  const DrinksItemCard({Key key, this.drinks}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var uid = Get.find<AuthController>().user.uid;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: Colors.black26,
          ),
        ],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
                child: FadeInImage.assetNetwork(
              placeholder: "assets/images/drinks/drinks_1.jpg",
              image: drinks.image,
              fit: BoxFit.cover,
            )),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      text: drinks.title,
                      style: Theme.of(context).textTheme.headline6,
                      children: [
                        WidgetSpan(child: SizedBox(width: 10)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.bottom,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            height: getProportionateScreenHeight(20),
                            width: getProportionateScreenHeight(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF3f8f48),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF3f8f48),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Text(
                    drinks.description,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Spacer(),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).primaryColor,
                    height: getProportionateScreenHeight(40),
                    onPressed: () {
                      CartItemModel cartItemModel = CartItemModel(
                        title: drinks.title,
                        image: drinks.image,
                        description: drinks.description,
                        price: drinks.price,
                        quantity: 1,
                      );
                      CartController().addToCart(cartItemModel.toJson(), uid);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Add",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                          "₹${drinks.price}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrinksItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black26,
          offset: Offset(5, 5),
        ),
      ]),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              enabled: true,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              height: 15,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: Colors.grey[300]),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              height: 15,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: Colors.grey[300]),
            ),
          ),
          Spacer(),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              height: 40,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
