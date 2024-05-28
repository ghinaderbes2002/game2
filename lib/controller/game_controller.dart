import 'dart:async';
import 'dart:convert';

import 'package:game2/controller/main_controller.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/model/round_model.dart';
import 'package:game2/view/screen/mainscreen.dart';
import 'package:get/get.dart';

abstract class GameController extends MainControllerImp {
  addLog();

  finishRound();

  pauseRound();

  resumeRound();

  checkLabels(String labels);
}

class GameControllerImp extends GameController {
  bool isPaused = false;
  int wordIndex = 0;
  Timer? timer;
  late RoundModel currentRound;

  @override
  addLog() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> postResponse = await apiClient.postData(
        url: '$serverLink/createLog',
        data: {
          "score": score,
          "mistake": mistake,
          "date": DateTime.now().toIso8601String(),
          "roundId": currentRound.id,
          "userId": userModel.id,
        },
      );
      print('POST Response Data: ${postResponse.data}');
      if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {
        myServices.sharedPreferences.remove("pausedRound");
        Get.off(() => const MainScreen());
      }
    } catch (error) {
      print(error);
    }
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        mistake++;
        if (mistake < 3) {
          nextWord();
        } else {
          timer.cancel();
          finishRound();
        }
      }
    });
  }

  void nextWord() {
    if (wordIndex < currentRound.words.length - 1) {
      wordIndex++;
      seconds.value = currentRound.words[wordIndex].seconds;
    } else {
      timer?.cancel();
      finishRound();
    }
    update();
  }

  @override
  checkLabels(String labels) {
    List labelsList = labels.split(",");
    print("\n\n\n\n\n ${labelsList}  \n\n\n\n\n");
    if (labelsList.contains(
        currentRound.words[wordIndex].word.toString().toLowerCase())) {
      score++;
      nextWord();
    }
  }

  @override
  finishRound() async {
    int roundIndex = -1;

    for (int i = 0; i < rounds.length; i++) {
      if (rounds[i].name == currentRound.name) {
        roundIndex = i;
        print(
            "--------------- \n\n\n\nRound index is  : $roundIndex -------------\n\n\n\n");
      }
    }

    if ((mistake < 3) && (score > (currentRound.words.length / 2))) {
      myServices.sharedPreferences.setInt('nextRoundIndex',
          roundIndex < rounds.length ? roundIndex + 1 : roundIndex);
      print(
          "--------------- \n\n\n\n next Round index is  : ${myServices.sharedPreferences.getInt('nextRoundIndex')} -------------\n\n\n\n");
      ApiClient apiClient = ApiClient();
      try {
        ApiResponse<dynamic> postResponse = await apiClient.postData(
          url: '$serverLink/createLog',
          data: {
            "score": 0,
            "mistake": 0,
            "date": DateTime.now().toIso8601String(),
            "roundId":
                rounds[roundIndex < rounds.length ? roundIndex + 1 : roundIndex]
                    .id,
            "userId": userModel.id,
          },
        );
        print('POST Response Data: ${postResponse.data}');
        if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {
          myServices.sharedPreferences.remove("pausedRound");
          Get.off(() => const MainScreen());
        }
      } catch (error) {
        print(error);
      }
    } else {
      myServices.sharedPreferences.setInt('nextRoundIndex', roundIndex);
    }
    addLog();
  }

  @override
  pauseRound() {
    Map stats = {
      'score': score,
      'mistake': mistake,
      'seconds': seconds.value,
      'roundId': currentRound.id,
      'wordIndex': wordIndex,
    };
    myServices.sharedPreferences.setString('pausedRound', json.encode(stats));
    timer?.cancel();
    isPaused = true;
  }

  @override
  resumeRound() {
    Map stats =
        json.decode(myServices.sharedPreferences.getString("pausedRound")!);
    score = stats['score'];
    mistake = stats['mistake'];
    seconds.value = stats['seconds'];
    wordIndex = stats['wordIndex'];
    isPaused = false;
    startTimer();
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    currentRound = RoundModel.fromJson(
        jsonDecode(myServices.sharedPreferences.getString("selectedRound")!));
    rounds = await getRounds();

    if (myServices.sharedPreferences.getString("pausedRound") != null) {
      Map stats =
          json.decode(myServices.sharedPreferences.getString("pausedRound")!);
      score = stats['score'];
      mistake = stats['mistake'];
      seconds.value = stats['seconds'];
      myServices.sharedPreferences.remove("pausedRound");
    } else {
      seconds.value = currentRound.words[wordIndex].seconds;
    }
    startTimer();
  }
}
