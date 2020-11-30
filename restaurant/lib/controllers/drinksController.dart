import 'package:get/get.dart';
import 'package:restaurant/models/drinks.dart';
import 'package:restaurant/services/database_service.dart';

class DrinksController extends GetxController {
  Rx<List<Drinks>> _drinksList = Rx<List<Drinks>>();
  List<Drinks> get drinksList => _drinksList.value;

  @override
  void onInit() {
    super.onInit();
    _drinksList.bindStream(DatabaseService().drinksStream());
  }
}
