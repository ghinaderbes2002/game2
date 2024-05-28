import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/view/screen/rounds_manage/roundsmanage.dart';
import 'package:get/get.dart';

abstract class UpdateroundController extends GetxController {
  updateRound();
}

class UpdateRoundControllerimp extends UpdateroundController {
  TextEditingController roundName2 = TextEditingController();
  TextEditingController roundWords = TextEditingController();

  @override
  updateRound() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> postResponse = await apiClient.putData(
        url: '$serverLink/updateRound',
        data: {
          "name": roundName2.text.trim(),
          "words": roundWords.text.split(','),
        },
      );
      print('POST Response Data: ${postResponse.data}');
      if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {
        print("updated successfully . . . ");
        Get.off(() => const RoundsManage());
      }
    } catch (error) {
      print(error);
    }
  }
}
