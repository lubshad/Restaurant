import 'package:get/get.dart';
import 'package:restaurant/models/sideModel.dart';
import 'package:restaurant/services/database_service.dart';

class SideItemController extends GetxController {
  Rx<List<SideItem>> _sidesList = Rx<List<SideItem>>();

  List<SideItem> get sidesList => _sidesList.value;

  @override
  void onInit() {
    super.onInit();
    _sidesList.bindStream(DatabaseService().sideStream());
  }
}
