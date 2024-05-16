import 'package:flutter/material.dart';
import 'package:game2/controller/home_controller.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/boxtext.dart';
import 'package:get/get.dart';
import 'package:game2/view/widget/auth/customtextbodyauth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerimp>(
        init: HomeControllerimp(),
        builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: ListView(
              children: [
                CustomTextBodyAuth(
                  text: controller.playerOfTheWeek.name,
                ),
                const SizedBox(
                  height: 15,
                ),
                const BoxText(
                  text: 'User name : ',
                  text2: 'Score :',
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButtonAuth(
                  text: "Start Game",
                  onPush: () {
                    controller.startGame();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButtonAuth(
                  text: "Resume",
                  onPush: () {
                    controller.resumeGame();
                  },
                ),
              ],
            )));
  }
}
