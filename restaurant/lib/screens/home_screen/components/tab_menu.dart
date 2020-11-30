import 'package:flutter/material.dart';
import 'package:restaurant/models/tab_menu_items.dart';
import 'package:restaurant/screens/home_screen/components/tab_menu_item_card.dart';

import '../../../size_config.dart';

class TabMenu extends StatelessWidget {
  const TabMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFe2e2e2)))),
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
        child: Row(
          children: [
            ...List.generate(
              tabMenuItems.length,
              (index) => TabMenuItemCard(
                tabMenuItem: tabMenuItems[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
