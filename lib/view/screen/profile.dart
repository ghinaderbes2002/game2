import 'package:flutter/material.dart';
import 'package:game2/controller/profile_controller.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/boxtext.dart';
import 'package:game2/view/widget/highscoreswidget.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileControllerimp>(
        init: ProfileControllerimp(),
        builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: ListView(
              children: [
                BoxText(text: controller.name),
                HighScoresWidget(text: controller.highScorce.toString()),
                const SizedBox(
                  height: 20,
                ),
                CustomButtonAuth(
                  text: "Signout",
                  onPush: () {
                    controller.signout();
                  },
                ),
              ],
            )));
  }
}
