import 'package:game2/controller/main_controller.dart';
import 'package:game2/view/screen/auth/screens/login_screen.dart';
import 'package:get/get.dart';

abstract class ProfileController extends MainControllerImp {
  signOut();
  calcHighScore();
}

class ProfileControllerImp extends ProfileController {
  int highScore = 0;

  @override
  signOut() {
    myServices.sharedPreferences.clear();
    Get.off(() => const LoginPage());
  }

  @override
  calcHighScore() {
    List<int> scores = userModel.logs.map((log) => log.score).toList();
    highScore = scores.isNotEmpty
        ? scores.reduce((value, element) => value > element ? value : element)
        : 0;
    print(
        "scores are   : ${userModel.name}    \n\n\n  and highscore is : ${highScore} ");
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchUser();
    calcHighScore();
  }
}
