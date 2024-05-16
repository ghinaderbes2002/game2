import 'package:game2/controller/main_controller.dart';
import 'package:get/get.dart';
import '../view/screen/auth/login.dart';

abstract class ProfileController extends MainControllerimp {
  signout();
  calcHighScore();
}

class ProfileControllerimp extends ProfileController {
  String name = "";
  int highScorce = 0;

  @override
  signout() {
    myServices.sharedPreferences.clear();
    Get.off(() => const Login());
  }

  @override
  calcHighScore() {
    List<int> scorces = userModel.logs.map((log) => log.score).toList();
    highScorce =
        scorces.reduce((value, element) => value > element ? value : element);
  }

  @override
  void onInit() {
    calcHighScore();
    name = userModel.name;
    super.onInit();
  }
}
