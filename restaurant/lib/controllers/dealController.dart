import 'package:get/get.dart';
import 'package:restaurant/models/deals_item_model.dart';
import 'package:restaurant/services/database_service.dart';

class DealsController extends GetxController {
  Rx<List<DealItem>> _dealsList = Rx<List<DealItem>>();
  List<DealItem> get dealsList => _dealsList.value;

  @override
  void onInit() {
    super.onInit();
    _dealsList.bindStream(DatabaseService().dealStream());
  }
}
