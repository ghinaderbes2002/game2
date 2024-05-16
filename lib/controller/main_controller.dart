import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/core/services/services.dart';
import 'package:game2/model/round_model.dart';
import 'package:game2/model/user_model.dart';
import 'package:game2/view/screen/home.dart';
import 'package:game2/view/screen/profile.dart';
import 'package:game2/view/screen/rounds.dart';
import 'package:get/get.dart';
import 'package:game2/core/classes/api_client.dart';

abstract class MainController extends GetxController {
  changePage(int index);
  fetchRounds();
  fetchUser();
}

class MainControllerimp extends MainController {
  List<RoundModel> rounds = [];
  late RoundModel selecteRound;
  late UserModel userModel;
   int score = 0;
  int mistake = 0;
 var seconds = 0.obs;

  MyServices myServices = Get.find();

  int currentScreen = 0;
  List<Widget> screens = [
    const Home(),
    const Rounds(),
    const Profile(),
  ];

  @override
  changePage(int index) {
    currentScreen = index;
    update();
  }

  @override
  fetchRounds() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> getResponse = await apiClient.getData(
        url: '$serverLink/getRound',
      );
      print('POST Response Data: ${getResponse.data}');
      rounds = getResponse.data['rounds']
          .map((roundJson) => RoundModel.fromJson(roundJson))
          .toList();
    } catch (error) {
      print('Error while making POST request: $error');
    }
  }

  @override
  fetchUser() {
    String? userModelString =
        myServices.sharedPreferences.getString("userModel");
    Map<String, dynamic> userModelJson = json.decode(userModelString!);
    userModel = UserModel.fromCache(userModelJson);
  }

  @override
  void onInit() {
    fetchUser();
    fetchRounds();
    super.onInit();
  }
}
