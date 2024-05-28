import 'dart:convert';

import 'package:game2/controller/main_controller.dart';
import 'package:game2/model/user_model.dart';
import 'package:game2/view/screen/gamescreen.dart';
import 'package:get/get.dart';

import '../core/classes/api_client.dart';
import '../core/constants/connection.dart';

abstract class HomeController extends MainControllerImp {
  startGame();
  resumeGame();

  fetchPlayerOfTheWeek();
}

class HomeControllerImp extends HomeController {
  UserModel playerOfTheWeek =
      UserModel(id: 0, name: "", password: "", logs: []);
  int weekHighScore = 0;

  @override
  startGame() {
    int? currentIndex = myServices.sharedPreferences.getInt('nextRoundIndex');
    myServices.sharedPreferences.setString(
        "selectedRound", jsonEncode(rounds[currentIndex ?? 0].toJson()));
    Get.to(() => GameScreen());
  }

  @override
  resumeGame() {
    Map stats =
        json.decode(myServices.sharedPreferences.getString("pausedRound")!);

    rounds.forEach((round) {
      if (round.id == stats['roundId']) {
        selectedRound = round;
        myServices.sharedPreferences
            .setString("selectedRound", jsonEncode(round.toJson()));
      }
    });
    Get.to(() => GameScreen());
  }

  @override
  Future<List> fetchPlayerOfTheWeek() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> getResponse = await apiClient.getData(
        url: '$serverLink/getPlayerOfWeek',
      );
      if (getResponse.data['playerWithHighestScore'] != null) {
        playerOfTheWeek =
            UserModel.forTopPlayer(getResponse.data['playerWithHighestScore']);
      }
      weekHighScore = getResponse.data['highestScore'];
      return [playerOfTheWeek, weekHighScore];
    } catch (error) {
      print('1 Error while making POST request: $error');
      return [];
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchPlayerOfTheWeek();
    rounds = await getRounds();
  }
}
