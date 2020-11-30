import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controllers/authController.dart';
import 'package:restaurant/screens/home_screen/home_screen.dart';
import 'package:restaurant/screens/sign_in/sign_in_screen.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.user.isNull)
        return HomeScreen();
      else
        return SignInScreen();
    });
  }
}
