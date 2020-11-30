import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/screens/account_screen/DeliverWithUs.dart';
import 'package:restaurant/screens/account_screen/Help.dart';
import 'package:restaurant/screens/account_screen/Promotions.dart';
import 'package:restaurant/screens/account_screen/RegisterWithUs.dart';
import 'package:restaurant/screens/account_screen/Wallet.dart';
import 'package:restaurant/screens/account_screen/aboutUs.dart';
import 'package:restaurant/screens/account_screen/manageAddressScreen.dart';
import 'package:restaurant/services/authService.dart';

class AccountMenuItem {
  final String title;
  final IconData icon;
  final GestureTapCallback press;

  AccountMenuItem({this.press, this.title, this.icon});
}

List<AccountMenuItem> accountMenuItems = [
  AccountMenuItem(
      title: "Wallet",
      icon: Icons.account_balance_wallet,
      press: () {
        Get.to(Wallet());
      }),
  AccountMenuItem(
      title: "Promotions",
      icon: Icons.local_offer,
      press: () {
        Get.to(Promotions());
      }),
  AccountMenuItem(
      title: "Manage Address",
      icon: Icons.person,
      press: () {
        Get.to(ManageAddressScreen());
      }),
  AccountMenuItem(
      title: "Help",
      icon: Icons.help_sharp,
      press: () {
        Get.to(Help());
      }),
  AccountMenuItem(
      title: "Register With Us",
      icon: Icons.app_registration,
      press: () {
        Get.to(RegisterWithUs());
      }),
  AccountMenuItem(
      title: "Deliver With Us",
      icon: Icons.delivery_dining,
      press: () {
        Get.to(DeliverWithUs());
      }),
  AccountMenuItem(
      title: "About Us",
      icon: Icons.business_outlined,
      press: () {
        Get.to(AboutUs());
      }),
  AccountMenuItem(
      title: "Logout",
      icon: Icons.logout,
      press: () {
        AuthService().signOut();
      }),
];
