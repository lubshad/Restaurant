import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant/controllers/orderController.dart';
import 'package:restaurant/models/orderModel.dart';
import 'package:get/get.dart';
import '../../../size_config.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    var liveOrderController = Get.find<LiveOrderController>();
    var time = DateFormat('dd MMM')
        .format(liveOrderController.liveOrderList[index].time.toDate());
    return InkWell(
      onTap: () {
        Get.to(TrackOrder(), arguments: index);
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        height: getProportionateScreenHeight(80),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: getProportionateScreenHeight(80),
              height: getProportionateScreenHeight(80),
              child: Image.asset(
                "assets/images/pizza/pizza_1.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: getProportionateScreenHeight(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Crispy Bay",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Spacer(),
                Text(
                  "${liveOrderController.liveOrderList[index].items.length} item ₹${liveOrderController.liveOrderList[index].totalPrice}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "$time ${statusToString(liveOrderController.liveOrderList[index].orderStatus)}",
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TrackOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = Get.arguments;
    var liveOrderController = Get.find<LiveOrderController>();
    List<String> orderStatusList = OrderStatus.values
        .map((value) => statusToString(value).toString())
        .toList();
    orderStatusList.removeWhere((element) => element == "Order Cancelled");
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
        elevation: 0,
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  DateFormat("EEE, dd MMM").format(
                      liveOrderController.liveOrderList[index].time.toDate()),
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Order Id : ${liveOrderController.liveOrderList[index].id.substring(liveOrderController.liveOrderList[index].id.length - 10)}",
                      style: Theme.of(context).textTheme.subtitle1),
                  Text(
                      "Amt: ₹${liveOrderController.liveOrderList[index].totalPrice}",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              SizedBox(height: 20),
              Text("ETA : 15 Minutes",
                  style: Theme.of(context).textTheme.headline6),
              Expanded(
                child: ListView.builder(
                  itemCount: orderStatusList.length,
                  itemBuilder: (context, statusIndex) => OrderStatusCard(
                    index: statusIndex < 1 ? statusIndex - 1 : statusIndex,
                    status: orderStatusList[statusIndex],
                    orderIndex: index,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black26,
                  )
                ]),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.place),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Address",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                                "${liveOrderController.liveOrderList[index].deliveryAddress.addressTag}"),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${liveOrderController.liveOrderList[index].deliveryAddress.address}",
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${liveOrderController.liveOrderList[index].deliveryAddress.geoLocation}",
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                                "${liveOrderController.liveOrderList[index].deliveryAddress.phoneNumber}"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  final int index;
  final String status;
  final int orderIndex;

  const OrderStatusCard({
    Key key,
    this.index,
    this.status,
    this.orderIndex,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var liveOrderController = Get.find<LiveOrderController>();
    DateTime expTime = liveOrderController.liveOrderList[orderIndex].time
        .toDate()
        .add(Duration(minutes: index < 1 ? 6 * (index + 1) : 6 * index));
    String formattedTime = DateFormat("hh:mm").format(expTime);
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.verified,
                color: liveOrderController
                            .liveOrderList[orderIndex].orderStatus.index >
                        index
                    ? Colors.green
                    : Colors.grey),
            SizedBox(width: 10),
            Icon(Icons.shopping_bag, color: Colors.grey, size: 42),
            SizedBox(width: 5),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(status,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline6),
                        SizedBox(height: 5),
                        Text(
                          "Order from Crispy Bay",
                          maxLines: 1,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(formattedTime, style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}
