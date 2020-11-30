import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/models/deals_item_model.dart';
import 'package:restaurant/screens/details_screen/details_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../size_config.dart';

class DealsCard extends StatelessWidget {
  const DealsCard({
    Key key,
    this.dealItem,
  }) : super(key: key);
  final DealItem dealItem;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.all(10),
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
              aspectRatio: 2.6,
              child: Container(
                child: Hero(
                  tag: dealItem.id,
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/deals/deal_1.jpg",
                    image: dealItem.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(20),
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      maxLines: 2,
                      text: TextSpan(
                        text: dealItem.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Text(
                      dealItem.includedItems.join(", "),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Spacer(),
                    Divider(
                      height: getProportionateScreenHeight(20),
                      color: Colors.black,
                      thickness: .25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "₹${dealItem.price.toString()}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenWidth(10)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Get.to(DetailsScreen(), arguments: dealItem);
                            },
                            child: Text(
                              "Select",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DealsShimmer extends StatelessWidget {
  const DealsShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(10, 10),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              enabled: true,
              child: AspectRatio(
                aspectRatio: 2,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              enabled: true,
              child: Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              enabled: true,
              child: Container(
                height: 20,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  enabled: true,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  enabled: true,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
