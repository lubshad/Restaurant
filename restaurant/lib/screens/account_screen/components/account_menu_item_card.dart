import 'package:flutter/material.dart';
import 'package:restaurant/models/account_menu_items.dart';

import '../../../size_config.dart';

class AccountMenuItemCard extends StatelessWidget {
  const AccountMenuItemCard({
    Key key,
    this.accountMenuItem,
  }) : super(key: key);

  final AccountMenuItem accountMenuItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: accountMenuItem.press,
      child: Container(
        margin:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: Row(
          children: [
            Icon(
              accountMenuItem.icon,
              size: getProportionateScreenHeight(50),
            ),
            SizedBox(width: getProportionateScreenHeight(20)),
            Text(
              accountMenuItem.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
