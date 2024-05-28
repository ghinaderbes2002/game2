import 'package:flutter/material.dart';
import 'package:game2/controller/home_controller.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/auth/customtextbodyauth.dart';
import 'package:game2/view/widget/boxtext.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImp>(
      init: HomeControllerImp()
        ..fetchUser()
        ..fetchRounds()
        ..fetchPlayerOfTheWeek(),
      builder: (controller) => Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: ListView(
              children: [
            const SizedBox(height: 100),
            const CustomTextBodyAuth(
              text: "Player of the week",
            ),
            const SizedBox(
                  height: 15,
                ),
            FutureBuilder<List>(
              future: controller.fetchPlayerOfTheWeek(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BoxText(
                    text: 'User name : ${snapshot.data![0].name}',
                    text2: 'Score : ${snapshot.data![1]}',
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
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
        ),
      ),
    );
  }
}
