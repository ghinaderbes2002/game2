import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/core/functions/showsnackbar.dart';
import 'package:game2/core/services/services.dart';
import 'package:game2/model/user_model.dart';
import 'package:game2/view/screen/auth/signup.dart';
import 'package:game2/view/screen/home.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login({required BuildContext context});
  goToSigUp();
  showPassword();
}

class LoginControllerimp extends LoginController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  MyServices myServices = Get.find();

  bool isObsecure = true;
  @override
  login({required BuildContext context}) async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> postResponse = await apiClient.postData(
        url: '$serverLink/login',
        data: {'name': username.text.trim(), 'password': password.text.trim()},
      );
      print('POST Response Data: ${postResponse.data}');
      if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {
        myServices.sharedPreferences.setString("logged", "1");
        UserModel userModel = UserModel.fromServer(postResponse.data);
        myServices.sharedPreferences
            .setString('userModel', json.encode(userModel.toJson()));
        Get.off(() => const Home());
      } else {
        showSnackBar(
            context: context,
            contentType: ContentType.failure,
            title: 'Warning',
            body: 'Wrong password');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  goToSigUp() {
    Get.offAll(() => const SigUp());
  }

  showPassword() {
    isObsecure = !isObsecure;
    update();
  }
}
