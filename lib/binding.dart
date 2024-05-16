import 'package:game2/controller/auth/login_controller.dart';
import 'package:get/get.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginControllerimp(), fenix: true);
  }
}
