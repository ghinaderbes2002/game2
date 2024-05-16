import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:get/get.dart';

abstract class AddRoundController extends GetxController {
  addRound();
}

class AddRoundControllerimp extends AddRoundController {
  TextEditingController roundname = TextEditingController();
  TextEditingController words = TextEditingController();

  @override
  addRound() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> postResponse = await apiClient.postData(
        url: '$serverLink/createround',
        data: {"name": roundname.text.trim(), "wodrs": words.text.split(',')},
      );
      print('POST Response Data: ${postResponse.data}');
      if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {}
    } catch (error) {
      print(error);
    }
  }
}
