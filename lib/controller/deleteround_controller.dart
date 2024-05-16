import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:get/get.dart';
import 'package:game2/core/constants/connection.dart';

abstract class DeleteRoundController extends GetxController {
  deleteRound();
}

class DeleteRoundControllerimp extends DeleteRoundController {
  TextEditingController chooseRound = TextEditingController();

  @override
  deleteRound() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> deleteResponse = await apiClient.deleteData(
        url: '$serverLink/createround',
        queryParameters: {"roundId": int.parse(chooseRound.text)},
      );
      print('POST Response Data: ${deleteResponse.data}');
      if (deleteResponse.statusCode == 200 ||
          deleteResponse.statusCode == 201) {}
    } catch (error) {
      print(error);
    }
  }
}
