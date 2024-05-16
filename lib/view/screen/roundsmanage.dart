import 'package:flutter/material.dart';
import 'package:game2/controller/roundsmanage_controller.dart';

import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/auth/customtextbodyauth.dart';
import 'package:get/get.dart';

class RoundsManage extends StatelessWidget {
  const RoundsManage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<RoundsManageControllerimp>(
        init: RoundsManageControllerimp(),
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: ListView(children: [
            const CustomTextBodyAuth(text: "Round Manage"),
            const SizedBox(
              height: 25,
            ),
            CustomButtonAuth(
              text: "Add Round",
              onPush: () {
                controller.Add();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButtonAuth(
              text: "Exit Round",
              onPush: () {
                controller.Exit();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButtonAuth(
              text: "Delete Round",
              onPush: () {
                controller.Delete();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
