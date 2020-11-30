import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/bottom_navigation_controller.dart';
import 'package:restaurant/models/custom_navigation_bar_item.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    Key key,
    this.menuItem,
  }) : super(key: key);
  final CustomNavigationMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    var navigationController = Get.find<NavigationController>();
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        navigationController.updateMenu(menuItem.menuInfo);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Icon(
                menuItem.icon,
                color:
                    navigationController.currentMenu.value == menuItem.menuInfo
                        ? Colors.black
                        : Color(0xFFafafaf),
              ),
            ),
            Text(menuItem.name),
          ],
        ),
      ),
    );
  }
}
