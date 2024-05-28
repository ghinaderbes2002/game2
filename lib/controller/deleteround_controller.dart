import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/view/screen/rounds_manage/roundsmanage.dart';
import 'package:get/get.dart';

abstract class DeleteRoundController extends GetxController {
  deleteRound();
}

class DeleteRoundControllerImp extends DeleteRoundController {
  TextEditingController chooseRound = TextEditingController();

  @override
  deleteRound() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> deleteResponse = await apiClient.deleteData(
        url: '$serverLink/deleteRound',
        queryParameters: {"name": chooseRound.text.trim()},
      );
      print('POST Response Data: ${deleteResponse.data}');
      if (deleteResponse.statusCode == 200 ||
          deleteResponse.statusCode == 201) {
        print("Deleted Successfully > > > ");
        Get.off(() => const RoundsManage());
      }
    } catch (error) {
      print(error);
    }
  }
}
