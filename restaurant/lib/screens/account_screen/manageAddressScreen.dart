import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/userController.dart';
import 'package:restaurant/screens/account_screen/addAdress.dart';
import 'package:restaurant/size_config.dart';

import 'components/addressCard.dart';

class ManageAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Saved Places",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.black,
                    )),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "Swipe left to edit/delete saved address",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Divider(),
            InkWell(
              onTap: () {
                Get.to(AddAddressScreen());
              },
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: getProportionateScreenHeight(10)),
                  Text(
                    "Add Address",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.green),
                  )
                ],
              ),
            ),
            Divider(),
            GetX<UserController>(
              init: Get.find<UserController>(),
              builder: (userController) {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => AddressCard(
                            addressModel: userController.addressModel[index],
                          ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: userController.addressModel.length),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
