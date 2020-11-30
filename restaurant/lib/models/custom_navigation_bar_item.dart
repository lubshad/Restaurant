import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigationMenuItem {
  String name;
  IconData icon;
  NavigationMenuInfo menuInfo;
  CustomNavigationMenuItem(this.menuInfo, {this.name, this.icon});
}

enum NavigationMenuInfo { Home, Search, Grocery, Orders, Account }

List<CustomNavigationMenuItem> navigationMenuItems = [
  CustomNavigationMenuItem(NavigationMenuInfo.Home,
      name: "Home", icon: Icons.home),
  // CustomNavigationMenuItem(NavigationMenuInfo.Grocery,
  //     name: "Cart", icon: Icons.local_grocery_store),
  // CustomNavigationMenuItem(NavigationMenuInfo.Search,
  //     name: "Search", icon: Icons.search),
  CustomNavigationMenuItem(NavigationMenuInfo.Orders,
      name: "Orders", icon: Icons.date_range),
  CustomNavigationMenuItem(NavigationMenuInfo.Account,
      name: "Account", icon: Icons.person),
];
