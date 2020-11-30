import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/models/addressModel.dart';
import 'package:restaurant/screens/account_screen/components/addressBottomSheet.dart';
import 'package:restaurant/screens/sign_up/components/default_button.dart';
import 'package:restaurant/screens/sign_up/components/form_error.dart';
import 'package:restaurant/services/database_service.dart';
import 'package:restaurant/size_config.dart';

import '../../../constants.dart';
import '../../custom_surfix_icon.dart';

class ConfirmLocationBottomSheet extends StatelessWidget {
  const ConfirmLocationBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter address details",
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(padding: EdgeInsets.all(20), child: AddressForm())),
    );
  }
}

class AddressForm extends StatefulWidget {
  const AddressForm({
    Key key,
  }) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String landmark;
  String addressTag;
  AddressModel currentAddress = Get.arguments;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildAddressTagFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLandmarkFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          Text(
            currentAddress.geoLocation,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: 20),
          DefaultButton(
            text: "Add Location on Map",
            press: () async {
              var response = await Get.to(AddressBottomSheet());
              if (response != null) {
                currentAddress.geoPoint = response["geoPoint"];
                currentAddress.geoLocation = response["place"];
                setState(() {});
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          DefaultButton(
            text: "Save Address",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                AddressModel addressModel = AddressModel(
                  addressTag: addressTag,
                  firstName: firstName,
                  lastName: lastName,
                  phoneNumber: phoneNumber,
                  address: address,
                  landMark: landmark,
                  geoPoint: currentAddress.geoPoint,
                  geoLocation: currentAddress.geoLocation,
                  id: currentAddress.id,
                );
                DatabaseService().updateAddress(addressModel);
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressTagFormField() {
    return TextFormField(
      initialValue: currentAddress.addressTag,
      onSaved: (newValue) => addressTag = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kaddressTagNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kaddressTagNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Tag Name",
        hintText: "Enter your Address tag name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildLandmarkFormField() {
    return TextFormField(
      initialValue: currentAddress.landMark,
      onSaved: (newValue) => landmark = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLandmarkNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kLandmarkNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Landmark",
        hintText: "Enter your Landmark",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      initialValue: currentAddress.address,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      initialValue: currentAddress.phoneNumber,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      initialValue: currentAddress.lastName,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLastNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kLastNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      initialValue: currentAddress.firstName,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kFirstNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
