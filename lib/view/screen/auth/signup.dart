import 'package:flutter/material.dart';
import 'package:game2/controller/auth/signup_controller.dart';
import 'package:game2/core/constants/color.dart';
import 'package:game2/core/functions/validinput.dart';
import 'package:game2/view/widget/auth/CustomTextTitleAuth.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/auth/customtextbodyauth.dart';
import 'package:game2/view/widget/auth/customtextformauth.dart';
import 'package:game2/view/widget/auth/customtextsiguporsigIn.dart';
import 'package:get/get.dart';

class SigUp extends StatelessWidget {
  const SigUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        elevation: 0.0,
        title: Text('Sign Up',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.gray)),
      ),
      body: GetBuilder<SignUpControllerimp>(
          builder: (controller) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
                            "sign Up With Your Email And Password OR Continue With Socail Media"),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormAuth(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 5, 100, "username");
                      },
                      mycontoller: controller.username,
                      hintText: "Enter your UserName",
                      labeltext: "UserName",
                      iconData: Icons.person_outline,
                    ),
                    CustomTextFormAuth(
                      valid: (val) {
                        return validInput(val!, 5, 100, "password");
                      },
                      isNumber: true,
                      mycontoller: controller.password,
                      hintText: "Enter your password",
                      labeltext: "password",
                      iconData: Icons.lock_outlined,
                    ),
                    CustomTextFormAuth(
                      isNumber: true,
                      valid: (val) {
                        return validInput(val!, 5, 100, "password");
                      },
                      mycontoller: controller.checkPassword,
                      hintText: "Enter your password",
                      labeltext: "Check Password",
                      iconData: Icons.lock_outlined,
                    ),
                    CustomButtonAuth(
                      text: "Sig Up",
                      onPush: () {
                        // controller.SigUp();
                        controller.signUp(context: context);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextSigUpOrSigIn(
                      textone: " have an account ?",
                      texttwo: " Sig In ",
                      onTap: () {
                        controller.goToSigIn();
                      },
                    ),
                  ],
                ),
              )),
    );
  }
}
