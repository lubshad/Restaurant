import 'package:get/get.dart';
import 'package:restaurant/models/addressModel.dart';
import 'package:restaurant/models/userModel.dart';
import 'package:restaurant/services/authService.dart';
import 'package:restaurant/services/database_service.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = Rx<UserModel>();
  UserModel get userModel => _userModel?.value;
  var prefferedDateTime = "ASAP".obs;

  Rx<List<AddressModel>> _addressModel = Rx<List<AddressModel>>();

  Rx<AddressModel> deliveryAddress = Rx<AddressModel>();

  List<AddressModel> get addressModel => _addressModel.value;

  int get addressCount => _addressModel.value?.length ?? 0;

  void scheduleTime(String scheduledTime) {
    prefferedDateTime.value = scheduledTime;
  }

  @override
  void onInit() async {
    super.onInit();
    _userModel.bindStream(AuthService().streamUser());
    deliveryAddress.bindStream(DatabaseService().getDeliveryAddress());
    _addressModel.bindStream(DatabaseService().getAddressStream());
  }
}
