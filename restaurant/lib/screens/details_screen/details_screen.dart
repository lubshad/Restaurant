import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/authController.dart';
import 'package:restaurant/controllers/cartController.dart';
import 'package:restaurant/controllers/drinksController.dart';
import 'package:restaurant/models/cartItem.dart';
import 'package:restaurant/models/deals_item_model.dart';
import 'package:restaurant/size_config.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedDrink = "Pepsi Black";
  final DealItem dealItem = Get.arguments;
  var user = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dealItem.title),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
            ),
            child: Icon(Icons.ios_share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2.5,
              child: Container(
                  child: Hero(
                tag: dealItem.id,
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: "assets/images/pizza/pizza_1.jpg",
                    image: dealItem.image),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(20),
                vertical: getProportionateScreenHeight(20),
              ),
              child: Text(
                dealItem.title,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 4,
                    ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(20),
                  vertical: getProportionateScreenHeight(10)),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(20),
                vertical: getProportionateScreenHeight(10),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFFf6f6f6),
              ),
              child: GetX<DrinksController>(
                init: Get.put(DrinksController()),
                builder: (drinksController) {
                  if (!drinksController.drinksList.isNull)
                    return DropdownButtonFormField(
                      value: selectedDrink,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      isExpanded: true,
                      items: drinksController.drinksList.map((drink) {
                        return DropdownMenuItem(
                          child: Text(drink.title),
                          value: drink.title,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDrink = value;
                        });
                      },
                    );
                  else
                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      isExpanded: true,
                      items: [DropdownMenuItem(child: Text("Loading"))],
                      onChanged: (value) {},
                    );
                },
              ),
            ),
            ...List.generate(
              dealItem.includedItems.length,
              (index) => IncludedContainer(
                item: dealItem.includedItems[index],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: getProportionateScreenHeight(10),
          right: getProportionateScreenHeight(20),
          bottom: getProportionateScreenWidth(10),
        ),
        height: getProportionateScreenHeight(65),
        child: FlatButton(
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              CartItemModel _cartItemModel = CartItemModel(
                  id: dealItem.id,
                  includedItems: dealItem.includedItems,
                  price: dealItem.price,
                  title: dealItem.title,
                  quantity: 1,
                  image: dealItem.image,
                  drink: selectedDrink);
              await CartController()
                  .addToCart(_cartItemModel.toJson(), user.user.uid);
              Get.back();
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Add To Basket",
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  "₹${dealItem.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }
}

class IncludedContainer extends StatelessWidget {
  const IncludedContainer({
    Key key,
    this.item,
  }) : super(key: key);
  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(20),
          vertical: getProportionateScreenHeight(10)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenHeight(20),
        vertical: getProportionateScreenHeight(10),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(3, 3),
          )
        ],
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFf6f6f6),
      ),
      child: Row(
        children: [
          Text(
            item,
            style: Theme.of(context).textTheme.headline6,
          ),
          Spacer(),
          Icon(Icons.verified, size: 50, color: Colors.green)
        ],
      ),
    );
  }
}
