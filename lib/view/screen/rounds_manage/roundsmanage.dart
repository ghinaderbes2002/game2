import 'package:flutter/material.dart';
import 'package:game2/view/screen/rounds_manage/deleteround.dart';
import 'package:game2/view/screen/rounds_manage/updateround.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/auth/customtextbodyauth.dart';
import 'package:get/get.dart';

import 'addround.dart';

class RoundsManage extends StatelessWidget {
  const RoundsManage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(children: [
            const CustomTextBodyAuth(text: "Round Manage"),
            const SizedBox(
              height: 25,
            ),
            CustomButtonAuth(
              text: "Add Round",
            onPush: () => Get.to(() => const AddRound()),
          ),
          const SizedBox(
              height: 20,
            ),
            CustomButtonAuth(
            text: "Update Round",
            onPush: () => Get.to(() => const Updateround()),
          ),
          const SizedBox(
              height: 20,
            ),
            CustomButtonAuth(
              text: "Delete Round",
            onPush: () => Get.to(() => const DeleteRound()),
          ),
        ]),
        ),
    );
  }
}
