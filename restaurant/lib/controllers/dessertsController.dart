import 'package:get/get.dart';
import 'package:restaurant/models/desserModel.dart';
import 'package:restaurant/services/database_service.dart';

class DessertsController extends GetxController {
  Rx<List<DessertItem>> _dessertsList = Rx<List<DessertItem>>();

  List<DessertItem> get dessertsList => _dessertsList.value;

  @override
  void onInit() {
    super.onInit();
    _dessertsList.bindStream(DatabaseService().dessertStream());
  }
}
