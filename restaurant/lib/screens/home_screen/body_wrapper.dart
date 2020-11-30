import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/bottom_navigation_controller.dart';
import 'package:restaurant/models/custom_navigation_bar_item.dart';
import 'package:restaurant/screens/account_screen/account_screen.dart';
import 'package:restaurant/screens/grocery_screen/grocery_screen.dart';
import 'package:restaurant/screens/home_screen/components/home_screen_body.dart';
import 'package:restaurant/screens/order_screen/order_screen.dart';
import 'package:restaurant/screens/search_screen/search_screen.dart';

import 'components/viewCartBottomNavigationBar.dart';

class BodyWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var navigationController = Get.put(NavigationController());
    return Scaffold(
      body: Obx(
        () {
          if (navigationController.currentMenu.value == NavigationMenuInfo.Home)
            return HomeScreenBody();
          if (navigationController.currentMenu.value ==
              NavigationMenuInfo.Search) return SearchScreen();
          if (navigationController.currentMenu.value ==
              NavigationMenuInfo.Grocery) return GroceryScreen();
          if (navigationController.currentMenu.value ==
              NavigationMenuInfo.Orders) return OrderScreen();
          if (navigationController.currentMenu.value ==
              NavigationMenuInfo.Account)
            return AccountScreen();
          else
            return null;
        },
      ),
      bottomNavigationBar: ViewCartBottomNavigationBar(),
    );
  }
}
