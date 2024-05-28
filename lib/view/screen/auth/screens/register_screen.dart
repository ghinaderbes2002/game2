import 'package:flutter/material.dart';
import 'package:game2/controller/auth/signup_controller.dart';
import 'package:get/get.dart';

import '../../../../core/constants/values/app_constants.dart';
import '../../../../core/constants/values/app_strings.dart';
import '../../../../core/constants/values/app_theme.dart';
import '../../../../core/functions/snackbar_helper.dart';
import '../../../../core/functions/utils/common_widgets/gradient_background.dart';
import '../../../widget/auth/app_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignUpControllerImp>(
          init: SignUpControllerImp(),
          builder: (controller) {
            return ListView(
              children: [
                const GradientBackground(
                  children: [
                    Text(AppStrings.register, style: AppTheme.titleLarge),
                    SizedBox(height: 6),
                    Text(AppStrings.createYourAccount,
                        style: AppTheme.bodySmall),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        AppTextFormField(
                          autofocus: true,
                          labelText: AppStrings.name,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) =>
                              controller.formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterName
                                : value.length < 4
                                    ? AppStrings.invalidName
                                    : null;
                          },
                          controller: controller.usernameController,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: controller.passwordNotifier,
                          builder: (_, passwordObscure, __) {
                            return AppTextFormField(
                              obscureText: passwordObscure,
                              controller: controller.passwordController,
                              labelText: AppStrings.password,
                              textInputAction: TextInputAction.next,
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
                              suffixIcon: Focus(
                                /// If false,
                                ///
                                /// disable focus for all of this node's descendants
                                descendantsAreFocusable: false,

                                /// If false,
                                ///
                                /// make this widget's descendants un-traversable.
                                // descendantsAreTraversable: false,
                                child: IconButton(
                                  onPressed: () => controller.passwordNotifier
                                      .value = !passwordObscure,
                                  style: IconButton.styleFrom(
                                    minimumSize: const Size.square(48),
                                  ),
                                  icon: Icon(
                                    passwordObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: controller.confirmPasswordNotifier,
                          builder: (_, confirmPasswordObscure, __) {
                            return AppTextFormField(
                              labelText: AppStrings.confirmPassword,
                              controller: controller.confirmPasswordController,
                              obscureText: confirmPasswordObscure,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (_) =>
                                  controller.formKey.currentState?.validate(),
                              validator: (value) {
                                return value!.isEmpty
                                    ? AppStrings.pleaseReEnterPassword
                                    : AppConstants.passwordRegex.hasMatch(value)
                                        ? controller.passwordController.text ==
                                                controller
                                                    .confirmPasswordController
                                                    .text
                                            ? null
                                            : AppStrings.passwordNotMatched
                                        : AppStrings.invalidPassword;
                              },
                              suffixIcon: Focus(
                                /// If false,
                                ///
                                /// disable focus for all of this node's descendants.
                                descendantsAreFocusable: false,

                                /// If false,
                                ///
                                /// make this widget's descendants un-traversable.
                                // descendantsAreTraversable: false,
                                child: IconButton(
                                  onPressed: () => controller
                                      .confirmPasswordNotifier
                                      .value = !confirmPasswordObscure,
                                  style: IconButton.styleFrom(
                                    minimumSize: const Size.square(48),
                                  ),
                                  icon: Icon(
                                    confirmPasswordObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: controller.fieldValidNotifier,
                          builder: (_, isValid, __) {
                            return FilledButton(
                              onPressed: isValid
                                  ? () {
                                      controller.signUp(context: context);
                                      SnackbarHelper.showSnackBar(
                                        AppStrings.registrationComplete,
                                      );
                                      controller.usernameController.clear();
                                      controller.passwordController.clear();
                                      controller.confirmPasswordController
                                          .clear();
                                    }
                                  : null,
                              child: const Text(AppStrings.register),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.iHaveAnAccount,
                      style: AppTheme.bodySmall.copyWith(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () => Get.offNamed(
                        "/",
                      ),
                      child: const Text(AppStrings.login),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
