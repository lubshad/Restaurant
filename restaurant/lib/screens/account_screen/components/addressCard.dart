import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/models/addressModel.dart';
import 'package:restaurant/services/database_service.dart';

import '../../../size_config.dart';
import 'confirmLocationBottomSheet.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key key,
    this.addressModel,
  }) : super(key: key);
  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        DatabaseService().deleteAddress(addressModel.id);
      },
      key: Key(addressModel.id),
      child: InkWell(
        onTap: () {
          Get.to(ConfirmLocationBottomSheet(), arguments: addressModel);
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10),
          ),
          child: Row(
            children: [
              Icon(Icons.place),
              SizedBox(width: getProportionateScreenHeight(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addressModel.addressTag,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      addressModel.firstName,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      addressModel.address,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      addressModel.landMark,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      addressModel.phoneNumber,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
