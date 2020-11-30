import 'package:flutter/material.dart';
import 'package:restaurant/controllers/userController.dart';
import 'package:get/get.dart';
import 'package:restaurant/services/database_service.dart';

class DeliveryAddressSelector extends StatelessWidget {
  const DeliveryAddressSelector({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserController>();
    return Obx(
      () => DropdownButtonFormField(
        decoration: InputDecoration(border: InputBorder.none),
        items: userController.addressModel.map((address) {
          return DropdownMenuItem(
            value: address,
            child: Text(
              address.addressTag,
              style: Theme.of(context).textTheme.headline6,
            ),
          );
        }).toList(),
        hint: Text(
            userController?.deliveryAddress?.value?.addressTag ??
                "Select Address",
            style: Theme.of(context).textTheme.headline6),
        onChanged: (address) {
          DatabaseService().setDeliveryAddress(address);
        },
      ),
    );
  }
}
