import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/core/services/services.dart';
import 'package:game2/model/round_model.dart';
import 'package:game2/model/user_model.dart';
import 'package:game2/view/screen/home.dart';
import 'package:game2/view/screen/profile.dart';
import 'package:game2/view/screen/rounds.dart';
import 'package:get/get.dart';

abstract class MainController extends GetxController {
  changePage(int index);
  fetchRounds();
  fetchUser();

  Future<List<RoundModel>> getRounds();
}

class MainControllerImp extends MainController {
  List<RoundModel> rounds = [];
  late RoundModel selectedRound;
  late UserModel userModel;
  int score = 0;
  int mistake = 0;
  var seconds = 120.obs;

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

      var roundsList = getResponse.data['rounds'] as List;

      rounds = roundsList
          .map((roundJson) => RoundModel.fromJson(roundJson))
          .toList();
      print(rounds[0].words);
      print('Rounds Data are : $rounds \n\n');
    } catch (error) {
      print('2 Error while making POST request: $error');
    }
  }

  @override
  Future<List<RoundModel>> getRounds() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> getResponse = await apiClient.getData(
        url: '$serverLink/getRound',
      );
      print('POST Response Data: ${getResponse.data}');

      List<dynamic> roundsList = getResponse.data['rounds'] ?? [];
      return roundsList
          .map((roundJson) => RoundModel.fromJson(roundJson))
          .toList();
    } catch (error) {
      print('Error while making POST request: $error');
      return [];
    }
  }

  @override
  fetchUser() {
    String? userModelString =
        myServices.sharedPreferences.getString("userModel");
    Map<String, dynamic> userModelJson = json.decode(userModelString!);
    userModel = UserModel.fromCache(userModelJson);
    print('User Data are : ${userModel.toJson()} \n\n');
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchUser();
    await fetchRounds();
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+@admin$');
    print(userModel.logs);
    myServices.sharedPreferences
        .setBool("isAdmin", regex.hasMatch(userModel.name));
  }
}