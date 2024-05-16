import 'dart:convert';

import 'package:game2/controller/main_controller.dart';
import 'package:game2/model/user_model.dart';
import 'package:game2/view/screen/gamescreen.dart';
import 'package:get/get.dart';

abstract class HomeController extends MainControllerimp {
  startGame();
  resumeGame();
  fatchPlayerOfTheWeek();
}

class HomeControllerimp extends HomeController {
  late UserModel playerOfTheWeek;
  int weekHighScore = 0;

  @override
  startGame() {
    int? currentIndex = myServices.sharedPreferences.getInt('nextRoundIndex');
    selecteRound = rounds[currentIndex ?? 0];
    Get.to(() => const GameScreen());
  }

  @override
  resumeGame() {
    Map stats = json.decode(myServices.sharedPreferences.getString("stats")!);
    rounds.forEach((round) {
      if (round.id == stats['roundId']) {
        selecteRound = round;
      }
    });
    score = stats['score'];
    mistake = stats['mistake'];
    seconds = stats['seconds'];
    Get.to(() => const GameScreen());
  }

  @override
  fatchPlayerOfTheWeek() {}

  @override
  void onInit() {
    fatchPlayerOfTheWeek();
    super.onInit();
  }
}
