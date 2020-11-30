import 'package:flutter/material.dart';
import 'package:restaurant/models/custom_navigation_bar_item.dart';

import '../../../size_config.dart';
import 'custom_bottom_navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(65),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFe2e2e2), width: 3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            navigationMenuItems.length,
            (index) => CustomBottomNavigationBarItem(
              menuItem: navigationMenuItems[index],
            ),
          ),
        ],
      ),
    );
  }
}
