import 'package:flutter/material.dart';
import 'package:game2/controller/auth/login_controller.dart';
import 'package:game2/core/constants/color.dart';
import 'package:game2/core/functions/validinput.dart';
import 'package:game2/view/widget/auth/CustomTextTitleAuth.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/auth/customtextbodyauth.dart';
import 'package:game2/view/widget/auth/customtextformauth.dart';
import 'package:game2/view/widget/auth/customtextsiguporsigIn.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerimp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        elevation: 0.0,
        title: Text('Sign In',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.gray)),
      ),
      body: GetBuilder<LoginControllerimp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: ListView(
            children: [
              const CustomTextTitleAuth(
                text: "Welcome Back",
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextBodyAuth(
                  text:
                      "sign In With Your Email And Password OR Continue With Socail Media"),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormAuth(
                isNumber: false,
                valid: (val) {
                  return validInput(val!, 5, 100, "username");
                },
                mycontoller: controller.username,
                hintText: "Enter your username",
                labeltext: "username",
                iconData: Icons.email_outlined,
              ),
              GetBuilder<LoginControllerimp>(
                builder: (controller) => CustomTextFormAuth(
                  obscureText: controller.isObsecure,
                  onTapIcon: () {
                    controller.showPassword();
                  },
                  isNumber: false,
                  valid: (val) {
                    return validInput(val!, 3, 30, "password");
                  },
                  mycontoller: controller.password,
                  hintText: "Enter your password",
                  labeltext: "password",
                  iconData: Icons.lock_outlined,
                ),
              ),
              CustomButtonAuth(
                text: "Sig In",
                onPush: () {
                  controller.login(context: context);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextSigUpOrSigIn(
                textone: "Don't have an account",
                texttwo: " SigUp",
                onTap: () {
                  controller.goToSigUp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
