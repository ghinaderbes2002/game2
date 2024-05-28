import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/core/functions/showsnackbar.dart';
import 'package:game2/core/services/services.dart';
import 'package:game2/model/user_model.dart';
import 'package:game2/view/screen/mainscreen.dart';
import 'package:get/get.dart';

import '../../core/constants/values/app_regex.dart';

abstract class LoginController extends GetxController {
  login({required BuildContext context});
}

class LoginControllerImp extends LoginController {
  late TextEditingController usernameController;

  late TextEditingController passwordController;
  MyServices myServices = Get.find();
  bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  void initializeControllers() {
    usernameController = TextEditingController()
      ..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    usernameController.dispose();
    passwordController.dispose();
  }

  void controllerListener() {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty && password.isEmpty) return;

    if (AppRegex.passwordRegex.hasMatch(password)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  login({required BuildContext context}) async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> postResponse = await apiClient.postData(
        url: '$serverLink/login',
        data: {
          'user_name': usernameController.text.trim(),
          'pass': passwordController.text.trim()
        },
      );
      print('POST Response Data: ${postResponse.data}');
      if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {
        myServices.sharedPreferences.setString("logged", "1");

        print("1111111111111");
        UserModel userModel = UserModel.fromServer(postResponse.data);
        print("9999999999999");
        myServices.sharedPreferences
            .setString('userModel', json.encode(userModel.toJson()));
        myServices.sharedPreferences
            .setString('userToken', postResponse.data['token']);

        RegExp regex = RegExp(r'^[a-zA-Z0-9]+@admin$');
        if (regex.hasMatch(usernameController.text.trim())) {
          myServices.sharedPreferences.setBool("isAdmin", true);
        } else {
          myServices.sharedPreferences.setBool("isAdmin", false);
        }

        Get.off(() => const MainScreen());
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
  void onInit() {
    initializeControllers();
    super.onInit();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
