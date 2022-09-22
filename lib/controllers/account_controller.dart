import 'package:get/get.dart';

class AccountController extends GetxController {
  RxString userName = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString role = "patient".obs;
  RxList<String> dbTimeSlots = <String>[].obs;
  RxString userId = "".obs;
}
