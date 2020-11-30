import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/orderController.dart';
import 'package:restaurant/screens/order_screen/components/order_item_card.dart';
import 'package:restaurant/size_config.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:
              Text("Your Orders", style: Theme.of(context).textTheme.headline6),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Live Orders"),
              Tab(text: "Past Orders"),
            ],
          ),
        ),
        body: TabBarView(children: [
          LiveOrderScreen(),
          PastOrderScreen(),
        ]),
      ),
    );
  }
}

class PastOrderScreen extends StatelessWidget {
  const PastOrderScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("You Dont Have Any Past Orders"),
    );
  }
}

class LiveOrderScreen extends StatelessWidget {
  const LiveOrderScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<LiveOrderController>(
      init: Get.put(LiveOrderController()),
      builder: (liveOrderController) {
        return Container(
          padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
          child: Column(
            children: [
              if (liveOrderController.count != 0)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => OrderItemCard(
                      index: index,
                    ),
                    itemCount: liveOrderController.count,
                    separatorBuilder: (context, index) => Divider(),
                  ),
                ),
              if (liveOrderController.count == 0)
                Expanded(
                  child: Center(
                    child: Text("You Dont Have Any Live Orders"),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
