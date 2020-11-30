import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/tab_menu_controller.dart';
import 'package:restaurant/models/tab_menu_items.dart';

import '../../../size_config.dart';

class TabMenuItemCard extends StatelessWidget {
  const TabMenuItemCard({
    Key key,
    this.tabMenuItem,
  }) : super(key: key);
  final TabMenuItem tabMenuItem;

  @override
  Widget build(BuildContext context) {
    var topTabController = Get.find<TopTabController>();
    return Obx(
      () => InkWell(
        onTap: () {
          topTabController.updateTab(tabMenuItem.tabMenuInfo);
        },
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(5)),
          decoration: BoxDecoration(
            color: topTabController.currentTab.value == tabMenuItem.tabMenuInfo
                ? Colors.black
                : Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: topTabController.currentTab.value == tabMenuItem.tabMenuInfo
              ? Text(
                  tabMenuItem.title,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(22),
                    color: Colors.white,
                  ),
                )
              : Text(tabMenuItem.title,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(22),
                  )),
        ),
      ),
    );
  }
}
