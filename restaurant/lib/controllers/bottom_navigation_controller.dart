import 'package:get/get.dart';
import 'package:restaurant/models/custom_navigation_bar_item.dart';

class NavigationController extends GetxController {
  var currentMenu = NavigationMenuInfo.Home.obs;
  updateMenu(NavigationMenuInfo menuInfo) {
    currentMenu.value = menuInfo;
  }
}
