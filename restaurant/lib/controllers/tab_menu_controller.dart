import 'package:get/get.dart';
import 'package:restaurant/models/tab_menu_items.dart';

class TopTabController extends GetxController {
  var currentTab = TabMenuInfo.Deals.obs;
  updateTab(TabMenuInfo tabMenuInfo) {
    currentTab.value = tabMenuInfo;
  }
}
