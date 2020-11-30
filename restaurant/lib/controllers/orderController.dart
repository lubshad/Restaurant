import 'package:get/get.dart';
import 'package:restaurant/models/orderModel.dart';
import 'package:restaurant/services/database_service.dart';

class LiveOrderController extends GetxController {
  Rx<List<OrderModel>> _liveOrderList = Rx<List<OrderModel>>();
  List<OrderModel> get liveOrderList => _liveOrderList.value;
  int get count => liveOrderList?.length ?? 0;
  @override
  void onInit() {
    super.onInit();
    _liveOrderList.bindStream(DatabaseService().liveOrderStream());
  }
}
