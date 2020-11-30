import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/cartController.dart';
import 'package:restaurant/models/cartItem.dart';
import 'package:restaurant/size_config.dart';

class CartItemExpansionTile extends StatelessWidget {
  const CartItemExpansionTile({
    Key key,
    this.cartItem,
  }) : super(key: key);

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.title,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 5),
                Text(
                  "₹${cartItem.price}",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "₹${cartItem.price * cartItem.quantity}",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 5),
              Container(
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenHeight(100),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          if (cartItem.quantity > 1)
                            CartController().decreaseQuantity(cartItem.id);
                          if (cartItem.quantity == 1)
                            CartController().deleteItem(cartItem.id);
                          if (Get.find<CartController>().count == 1 &&
                              cartItem.quantity == 1) Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.remove),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          cartItem.quantity.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          CartController().increaseQuantity(cartItem.id);
                        },
                        child: Container(
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      childrenPadding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
      children: [
        if (cartItem?.includedItems?.length == null)
          if (cartItem?.size != null)
            Align(
              alignment: Alignment.center,
              child: Text(
                cartItem.size,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.grey),
              ),
            ),
        if (cartItem?.description != null)
          ...List.generate(
            1,
            (index) => Align(
              alignment: Alignment.center,
              child: Text(
                cartItem.description,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.grey),
              ),
            ),
          ),
        if (cartItem?.includedItems?.length != null)
          if (cartItem?.drink != null)
            Align(
              alignment: Alignment.center,
              child: Text(
                cartItem.drink,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.grey),
              ),
            ),
        if (cartItem?.size != null)
          Align(
            alignment: Alignment.center,
            child: Text(
              cartItem.size,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.grey),
            ),
          ),
        if (cartItem?.includedItems != null)
          ...List.generate(
            cartItem.includedItems?.length,
            (index) => Align(
              alignment: Alignment.center,
              child: Text(
                cartItem.includedItems[index],
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
}
