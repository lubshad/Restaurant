import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/authController.dart';
import 'package:restaurant/controllers/cartController.dart';
import 'package:restaurant/models/cartItem.dart';
import 'package:restaurant/models/sideModel.dart';
import 'package:restaurant/size_config.dart';
import 'package:shimmer/shimmer.dart';

class SidesItemCard extends StatelessWidget {
  const SidesItemCard({
    Key key,
    this.sideItem,
  }) : super(key: key);
  final SideItem sideItem;

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
                placeholder: "assets/images/sides/sides_1.jpg",
                image: sideItem.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: sideItem.title,
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
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).primaryColor,
                    height: getProportionateScreenHeight(40),
                    onPressed: () {
                      CartItemModel cartItemModel = CartItemModel(
                        title: sideItem.title,
                        image: sideItem.image,
                        description: sideItem.description,
                        price: sideItem.price,
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
                          "₹${sideItem.price}",
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

class SideItemsShimmer extends StatelessWidget {
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
