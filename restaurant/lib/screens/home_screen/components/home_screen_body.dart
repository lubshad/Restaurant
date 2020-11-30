import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurant/controllers/dealController.dart';
import 'package:restaurant/controllers/dessertsController.dart';
import 'package:restaurant/controllers/drinksController.dart';
import 'package:restaurant/controllers/menuController.dart';
import 'package:restaurant/controllers/sideController.dart';
import 'package:restaurant/controllers/tab_menu_controller.dart';
import 'package:restaurant/controllers/userController.dart';
import 'package:restaurant/models/tab_menu_items.dart';
import 'package:restaurant/screens/home_screen/components/tab_menu.dart';
import 'package:restaurant/screens/home_screen/deals_view/deals_card.dart';
import 'package:restaurant/screens/home_screen/desserts_view/desserts_item_card.dart';
import 'package:restaurant/screens/home_screen/drinks_view/drinks_item_card.dart';
import 'package:restaurant/screens/home_screen/menu_view/menu_item_card.dart';
import 'package:restaurant/screens/home_screen/sides_view/sides_item_card.dart';
import 'package:restaurant/screens/account_screen/addAdress.dart';
import 'package:restaurant/size_config.dart';
import 'package:restaurant/screens/home_screen/components/DeliveryAddressSelector.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var topTabController = Get.put(TopTabController());
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Row(children: [
              DateTimePicker(),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward_ios_sharp),
              SizedBox(width: 10),
              AddressAppBar(),
            ]),
            bottom: PreferredSize(
              preferredSize: MediaQuery.of(context).size * .06,
              child: TabMenu(),
            ),
          ),
          if (topTabController.currentTab.value == TabMenuInfo.Deals)
            GetX<DealsController>(
              init: Get.put(DealsController()),
              builder: (dealsController) {
                if (!dealsController.dealsList.isNull)
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      List.generate(
                        dealsController.dealsList.length,
                        (index) => DealsCard(
                          dealItem: dealsController.dealsList[index],
                        ),
                      ),
                    ),
                  );
                else
                  return SliverList(
                    delegate: SliverChildListDelegate(
                        List.generate(3, (index) => DealsShimmer())),
                  );
              },
            ),
          if (topTabController.currentTab.value == TabMenuInfo.Menu)
            GetX<MenuItemsController>(
              init: Get.put(MenuItemsController()),
              builder: (menuItemsController) {
                if (!menuItemsController.menuList.isNull)
                  return SliverPadding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => MenuItemCard(
                          menuItem: menuItemsController.menuList[index],
                        ),
                        childCount: menuItemsController.menuList.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .52,
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenWidth(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                      ),
                    ),
                  );
                else
                  return SliverPadding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => MenuItemShimmer(),
                        childCount: 6,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .52,
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenWidth(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                      ),
                    ),
                  );
              },
            ),
          if (topTabController.currentTab.value == TabMenuInfo.Sides)
            GetX<SideItemController>(
              init: Get.put(SideItemController()),
              builder: (sideItemController) {
                if (!sideItemController.sidesList.isNull)
                  return SliverPadding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => SidesItemCard(
                          sideItem: sideItemController.sidesList[index],
                        ),
                        childCount: sideItemController.sidesList.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .7,
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenWidth(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                      ),
                    ),
                  );
                else
                  return SliverPadding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => SideItemsShimmer(),
                        childCount: 6,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .7,
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenWidth(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                      ),
                    ),
                  );
              },
            ),
          if (topTabController.currentTab.value == TabMenuInfo.Desserts)
            GetX<DessertsController>(
              init: Get.put(DessertsController()),
              builder: (dessertsController) {
                if (!dessertsController.dessertsList.isNull)
                  return SliverPadding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => DessertItemCard(
                          dessertItem: dessertsController.dessertsList[index],
                        ),
                        childCount: dessertsController.dessertsList.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .7,
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenWidth(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                      ),
                    ),
                  );
                else
                  return SliverPadding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => DessertItemShimmer(),
                        childCount: 6,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .7,
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenWidth(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                      ),
                    ),
                  );
              },
            ),
          if (topTabController.currentTab.value == TabMenuInfo.Drinks)
            GetX<DrinksController>(
              init: Get.put(DrinksController()),
              builder: (drinksController) {
                if (!drinksController.drinksList.isNull)
                  return SliverPadding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => DrinksItemCard(
                          drinks: drinksController.drinksList[index],
                        ),
                        childCount: drinksController.drinksList.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .7,
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenWidth(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                      ),
                    ),
                  );
                else
                  return SliverPadding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => DrinksItemShimmer(),
                        childCount: 6,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .7,
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenWidth(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                      ),
                    ),
                  );
              },
            ),
        ],
      ),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  Widget build(BuildContext context) {
    DateTime dateToday = DateTime.now();
    TimeOfDay timeNow = TimeOfDay.now();
    DateTime datePicked;
    TimeOfDay timePicked;
    String scheduledDateTime;
    return GetX<UserController>(
      init: Get.put(UserController()),
      builder: (userController) {
        return InkWell(
            onTap: () async {
              if (userController.prefferedDateTime.value != "ASAP")
                userController.scheduleTime("ASAP");
              else {
                datePicked = await showDatePicker(
                    context: context,
                    initialDate: dateToday,
                    firstDate: dateToday,
                    lastDate: dateToday.add(Duration(days: 7)));
                if (datePicked != null) {
                  timePicked = await showTimePicker(
                      context: context,
                      initialTime: timeNow.replacing(hour: timeNow.hour + 1));
                  if (datePicked != null && timePicked != null) {
                    scheduledDateTime =
                        "${DateFormat('EEE').format(datePicked)} ${timePicked.format(context)}";
                    userController.scheduleTime(scheduledDateTime);
                  }
                }
              }
            },
            child: Text(userController.prefferedDateTime.value));
      },
    );
  }
}

class AddressAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      init: Get.find<UserController>(),
      builder: (userController) {
        if (userController.addressCount == 0) {
          return InkWell(
            onTap: () {
              Get.to(AddAddressScreen());
            },
            child: Text(
              "Add Address",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.green),
            ),
          );
        }
        if (userController.addressCount != 0) {
          return Expanded(child: Container(child: DeliveryAddressSelector()));
        } else
          return null;
      },
    );
  }
}
