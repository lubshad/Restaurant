import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/authController.dart';
import 'package:restaurant/controllers/cartController.dart';
import 'package:restaurant/models/cartItem.dart';
import 'package:restaurant/models/menuItem.dart';
import 'package:restaurant/size_config.dart';
import 'package:shimmer/shimmer.dart';

class MenuItemCard extends StatefulWidget {
  const MenuItemCard({
    Key key,
    this.menuItem,
  }) : super(key: key);
  final MenuItem menuItem;

  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  String selectedSize = "Medium Pan";

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
            aspectRatio: 1.4,
            child: Container(
              child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/pizza/pizza_1.jpg",
                  image: widget.menuItem.image),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                      text: widget.menuItem.title,
                      style: Theme.of(context).textTheme.headline6,
                      children: [
                        WidgetSpan(child: SizedBox(width: 5)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xFFf7d25a)),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "NEW",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text("Select your size & crust",
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10)),
                        width: double.infinity,
                        height: getProportionateScreenHeight(40),
                        decoration: BoxDecoration(
                          color: Color(0xFFe7e9ec),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField(
                          value: selectedSize,
                          decoration: InputDecoration(border: InputBorder.none),
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                                value: "Medium Pan",
                                child: Text(
                                  "Medium Pan",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )),
                            DropdownMenuItem(
                                value: "Small Pan",
                                child: Text(
                                  "Small Pan",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )),
                            DropdownMenuItem(
                              value: "Large Pan",
                              child: Text("Large Pan",
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Theme.of(context).primaryColor,
                        height: getProportionateScreenHeight(40),
                        onPressed: () {
                          CartItemModel cartItemModel = CartItemModel(
                            image: widget.menuItem.image,
                            includedItems: widget.menuItem.includedItems,
                            price: widget.menuItem.price,
                            title: widget.menuItem.title,
                            quantity: 1,
                            size: selectedSize,
                          );
                          CartController()
                              .addToCart(cartItemModel.toJson(), uid);
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
                              "₹${widget.menuItem.price}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black26,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.4,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[300]),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[300]),
            ),
          ),
          Spacer(),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            enabled: true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
