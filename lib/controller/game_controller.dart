import 'dart:async';
import 'dart:convert';
import 'package:game2/controller/main_controller.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:get/get.dart';

abstract class GameController extends MainControllerimp {
  addLog();
  finishRound();
  pauseRound();
  resumeRound();
}

class GameControllerimp extends GameController {
  bool isPaused = false;
  int wordIndex = 0;
  String currentWord = "";
  Timer? timer;

  @override
  addLog() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> postResponse = await apiClient.postData(
        url: '$serverLink/createLog',
        data: {
          "score": score,
          "mistake": mistake,
          "date": DateTime.now(),
          "roundId": selecteRound.id,
          "userId": userModel.id,
        },
      );
      print('POST Response Data: ${postResponse.data}');
      if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {}
    } catch (error) {
      print(error);
    }
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds.value++;
    });
  }

  setCurrentWord() {
    currentWord = selecteRound.words[wordIndex].word;
  }

  void nextWord() {
    wordIndex++;
    update();
  }

  @override
  finishRound() {
    addLog();
    int roundIndex = rounds.indexOf(selecteRound);
    myServices.sharedPreferences.setInt('nextRoundIndex', roundIndex + 1);
  }

  @override
  pauseRound() {
    Map stats = {
      'score': score,
      'mistake': mistake,
      'date': seconds,
      'roundId': selecteRound.id,
      'wordIndex': wordIndex,
    };
    myServices.sharedPreferences.setString('pauseRound', json.encode(stats));
    timer?.cancel();
    isPaused = true;
  }

  @override
  resumeRound() {
    Map stats =
        json.decode(myServices.sharedPreferences.getString("pauseRound")!);
    score = stats['score'];
    mistake = stats['mistake'];
    seconds = stats['seconds'];
    isPaused = false;
    startTimer();
    update();
  }

  @override
  void onInit() {
    startTimer();
    setCurrentWord();
    super.onInit();
  }
}
