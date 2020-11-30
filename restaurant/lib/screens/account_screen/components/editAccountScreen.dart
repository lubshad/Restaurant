import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'package:restaurant/controllers/userController.dart';
import 'package:restaurant/models/userModel.dart';
import 'package:restaurant/screens/sign_up/components/default_button.dart';
import 'package:restaurant/screens/sign_up/components/form_error.dart';
import 'package:restaurant/services/authService.dart';
import 'package:restaurant/services/database_service.dart';

import '../../../constants.dart';
import '../../custom_surfix_icon.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  var userController = Get.find<UserController>();
  PickedFile imageFile;
  File croppedImage;
  List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Account"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Obx(
                      () {
                        if (userController.userModel?.profilePicture != null) {
                          return Hero(
                            tag: userController.userModel.id,
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(userController
                                          .userModel.profilePicture),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        } else
                          return Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                          );
                      },
                    ),
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: Icon(Icons.photo),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: Icon(Icons.camera),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Obx(
                () => Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildFirstNameFormField(),
                      SizedBox(height: 20),
                      buildLastNameFormField(),
                      SizedBox(height: 20),
                      buildPhoneNumberFormField(),
                      SizedBox(height: 20),
                      FormError(errors: errors),
                      SizedBox(height: 20),
                      DefaultButton(
                        text: "Update",
                        press: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            UserModel userModel = UserModel(
                                firstName: firstName,
                                lastName: lastName,
                                phoneNumber: phoneNumber,
                                email: userController.userModel.email,
                                profilePicture:
                                    userController.userModel.profilePicture);
                            await AuthService().updateUser(userModel);
                            Get.back();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    // ignore: invalid_use_of_visible_for_testing_member
    PickedFile selected = await ImagePicker.platform.pickImage(source: source);
    if (selected != null) {
      imageFile = selected;
      await _cropImage();
      if (croppedImage != null) _imageUploader();
    }
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(sourcePath: imageFile.path);
    croppedImage = cropped;
  }

  void _imageUploader() async {
    final FirebaseStorage _storage =
        FirebaseStorage.instanceFor(bucket: "gs://learn-6c78b.appspot.com");
    UploadTask _uploadTask;
    String userId = userController.userModel.id;
    String filePath = "Images/UserProfile/$userId.png";
    _uploadTask = _storage.ref().child(filePath).putFile(croppedImage);
    _uploadTask.whenComplete(() async {
      var url = await _storage.ref().child(filePath).getDownloadURL();
      DatabaseService().setProfilePicture(url);
    });
  }

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

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      initialValue: userController.userModel.phoneNumber,
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
      initialValue: userController.userModel.lastName,
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
      initialValue: userController.userModel.firstName,
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      initialValue: userController.userModel.email,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
