import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/userController.dart';
import 'package:restaurant/models/account_menu_items.dart';
import 'package:restaurant/size_config.dart';

import 'components/account_menu_item_card.dart';
import 'components/editAccountScreen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenHeight(20)),
              child: InkWell(
                onTap: () {
                  Get.to(EditAccountScreen());
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetX<UserController>(
                              init: Get.find<UserController>(),
                              builder: (userController) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        userController.userModel.firstName
                                            .toUpperCase(),
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Text(
                              "View Account",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GetX<UserController>(
                      init: Get.find<UserController>(),
                      builder: (userController) {
                        if (userController.userModel?.profilePicture != null)
                          return Hero(
                            tag: userController.userModel.id,
                            child: Container(
                              height: getProportionateScreenHeight(100),
                              width: getProportionateScreenHeight(100),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(userController
                                        .userModel.profilePicture),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          );
                        else
                          return Container(
                            height: getProportionateScreenHeight(100),
                            width: getProportionateScreenHeight(100),
                          );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => AccountMenuItemCard(
                  accountMenuItem: accountMenuItems[index],
                ),
                separatorBuilder: (context, index) => Divider(height: 0),
                itemCount: accountMenuItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
