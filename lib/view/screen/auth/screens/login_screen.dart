import 'package:flutter/material.dart';
import 'package:game2/controller/auth/login_controller.dart';
import 'package:get/get.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/constants/values/app_constants.dart';
import '../../../../core/constants/values/app_strings.dart';
import '../../../../core/constants/values/app_theme.dart';
import '../../../../core/functions/snackbar_helper.dart';
import '../../../../core/functions/utils/common_widgets/gradient_background.dart';
import '../../../widget/auth/app_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginControllerImp>(
          init: LoginControllerImp(),
          builder: (controller) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const GradientBackground(
                  children: [
                    Text(
                      AppStrings.signInToYourNAccount,
                      style: AppTheme.titleLarge,
                    ),
                    SizedBox(height: 6),
                    Text(AppStrings.signInToYourAccount,
                        style: AppTheme.bodySmall),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextFormField(
                          controller: controller.usernameController,
                          labelText: AppStrings.username,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) =>
                              controller.formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterUserName
                                : GetUtils.isUsername(value)
                                    ? null
                                    : AppStrings.invalidUsername;
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: controller.passwordNotifier,
                          builder: (_, passwordObscure, __) {
                            return AppTextFormField(
                              obscureText: passwordObscure,
                              controller: controller.passwordController,
                              labelText: AppStrings.password,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (_) =>
                                  controller.formKey.currentState?.validate(),
                              validator: (value) {
                                return value!.isEmpty
                                    ? AppStrings.pleaseEnterPassword
                                    : AppConstants.passwordRegex.hasMatch(value)
                                        ? null
                                        : AppStrings.invalidPassword;
                              },
                              suffixIcon: IconButton(
                                onPressed: () => controller
                                    .passwordNotifier.value = !passwordObscure,
                                style: IconButton.styleFrom(
                                  minimumSize: const Size.square(48),
                                ),
                                icon: Icon(
                                  passwordObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder(
                          valueListenable: controller.fieldValidNotifier,
                          builder: (_, isValid, __) {
                            return FilledButton(
                              onPressed: isValid
                                  ? () {
                                      controller.login(context: context);
                                      SnackbarHelper.showSnackBar(
                                        AppStrings.loggedIn,
                                      );
                                      controller.usernameController.clear();
                                      controller.passwordController.clear();
                                    }
                                  : null,
                              child: const Text(AppStrings.login),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.doNotHaveAnAccount,
                      style: AppTheme.bodySmall.copyWith(color: Colors.black),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () => Get.offNamed(
                        AppRoute.signUp,
                      ),
                      child: const Text(AppStrings.register),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
