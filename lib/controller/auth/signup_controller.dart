import 'package:flutter/material.dart';
import 'package:game2/core/classes/api_client.dart';
import 'package:game2/core/constants/connection.dart';
import 'package:game2/core/functions/showsnackbar.dart';
import 'package:game2/view/screen/auth/login.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

abstract class SignUpController extends GetxController {
  signUp({required BuildContext context});
  goToSigIn();
  checkPasswordMatch();
}

class SignUpControllerimp extends SignUpController {
  TextEditingController password = TextEditingController();
  TextEditingController checkPassword = TextEditingController();
  TextEditingController username = TextEditingController();
  bool isObsecure = true;

  @override
  signUp({required BuildContext context}) async {
    bool isMatch = checkPasswordMatch();
    ApiClient apiClient = ApiClient();
    if (isMatch) {
      try {
        ApiResponse<dynamic> postResponse = await apiClient.postData(
          url: '$serverLink/signup',
          data: {
            'name': username.text.trim(),
            'password': password.text.trim()
          },
        );
        print('POST Response Data: ${postResponse.data}');
        if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {
          Get.off(() => const Login());
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
  goToSigIn() {
    Get.offAll(() => const Login());
  }

  @override
  bool checkPasswordMatch() {
    return password.text.trim() == checkPassword.text.trim();
  }
}
