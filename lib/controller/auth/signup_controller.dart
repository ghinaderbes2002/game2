import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/core/functions/showsnackbar.dart';
import 'package:get/get.dart';

import '../../core/constants/routes.dart';
import '../../core/constants/values/app_regex.dart';

abstract class SignUpController extends GetxController {
  signUp({required BuildContext context});
  checkPasswordMatch();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController usernameController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;

  bool isObscure = true;
  final formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  void initializeControllers() {
    usernameController = TextEditingController()
      ..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListener() {
    final name = usernameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty && password.isEmpty && confirmPassword.isEmpty) return;

    if (AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  signUp({required BuildContext context}) async {
    print("1");
    bool isMatch = checkPasswordMatch();
    print("2");
    ApiClient apiClient = ApiClient();
    print("3");
    if (isMatch) {
      print("4");
      try {
        ApiResponse<dynamic> postResponse = await apiClient.postData(
          url: '$serverLink/signup',
          data: {
            'user_name': usernameController.text.trim(),
            'pass': passwordController.text.trim()
          },
        );
        print('POST Response Data: ${postResponse.data}');

        if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {
          Get.offNamed(AppRoute.login);
        }
      } catch (error) {
        print('Error while making POST request: $error');
      }
    } else {
      showSnackBar(
          context: context,
          contentType: ContentType.warning,
          title: 'Warning',
          body: 'password confirmation failed');
    }
  }

  @override
  bool checkPasswordMatch() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
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
