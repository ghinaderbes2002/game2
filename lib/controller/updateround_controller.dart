import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:get/get.dart';

abstract class UpdateroundController extends GetxController {
  updateRound();
}

class UpdateRoundControllerimp extends UpdateroundController {
  TextEditingController roundName2 = TextEditingController();
  TextEditingController roundWords = TextEditingController();
  TextEditingController roundId = TextEditingController();

  @override
  updateRound() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> postResponse = await apiClient.postData(
        url: '$serverLink/updateRound',
        data: {
          "roundname2": roundName2.text.trim(),
          "word": roundWords.text.split(','),
        },
        queryParameters: {"roundId": int.parse(roundId.text)},
      );
      print('POST Response Data: ${postResponse.data}');
      if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {}
    } catch (error) {
      print(error);
    }
  }
}
