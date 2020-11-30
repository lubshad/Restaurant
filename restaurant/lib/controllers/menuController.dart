import 'package:get/get.dart';
import 'package:restaurant/models/menuItem.dart';
import 'package:restaurant/services/database_service.dart';

class MenuItemsController extends GetxController {
  Rx<List<MenuItem>> _menuList = Rx<List<MenuItem>>();
  List<MenuItem> get menuList => _menuList.value;

  @override
  void onInit() {
    super.onInit();
    _menuList.bindStream(DatabaseService().menuStream());
  }
}
