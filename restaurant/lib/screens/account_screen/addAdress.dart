import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/models/addressModel.dart';
import 'package:restaurant/screens/sign_up/components/default_button.dart';
import 'package:restaurant/screens/sign_up/components/form_error.dart';
import 'package:restaurant/services/database_service.dart';

import '../../constants.dart';
import '../../size_config.dart';
import '../custom_surfix_icon.dart';
import 'components/addressBottomSheet.dart';

class AddAddressScreen extends StatelessWidget {
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
  GeoPoint geoPoint;
  String geoLocation = "Add Current Location / Add Location On Map";
  bool mapAdded = false;
  bool mapText = false;

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
          Visibility(
            visible: mapText ? true : false,
            child: Text(
              geoLocation,
              maxLines: 2,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: mapAdded ? Colors.black : Colors.red,
                  ),
            ),
          ),
          SizedBox(height: 20),
          DefaultButton(
            text: "Add Location on Map",
            press: () async {
              var response = await Get.to(AddressBottomSheet());
              if (response != null) {
                geoPoint = response["geoPoint"];
                geoLocation = response["place"];
                mapAdded = true;
                mapText = true;
                setState(() {});
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          DefaultButton(
            text: "Add Address",
            press: () async {
              if (_formKey.currentState.validate() && mapAdded) {
                _formKey.currentState.save();
                AddressModel addressModel = AddressModel(
                  addressTag: addressTag,
                  firstName: firstName,
                  lastName: lastName,
                  phoneNumber: phoneNumber,
                  address: address,
                  landMark: landmark,
                  geoPoint: geoPoint,
                  geoLocation: geoLocation,
                );
                await DatabaseService().addAddress(addressModel);
                Get.back();
              } else
                setState(() {
                  mapText = true;
                });
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressTagFormField() {
    return TextFormField(
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
        hintText: "Enter your address",
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
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        if (value.length == 10) {
          removeError(error: kPhoneNumberInvalidError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        if (value.length != 10) {
          addError(error: kPhoneNumberInvalidError);
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
