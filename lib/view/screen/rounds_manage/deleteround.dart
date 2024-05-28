import 'package:flutter/material.dart';
import 'package:game2/controller/deleteround_controller.dart';
import 'package:game2/core/functions/validinput.dart';
import 'package:game2/view/screen/rounds_manage/roundsmanage.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/auth/customtextformauth.dart';
import 'package:get/get.dart';

class DeleteRound extends StatelessWidget {
  const DeleteRound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.off(() => const RoundsManage()),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: GetBuilder<DeleteRoundControllerImp>(
            init: DeleteRoundControllerImp(),
            builder: (controller) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ListView(children: [
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 3, 100, "round_word");
                    },
                    mycontoller: controller.chooseRound,
                    hintText: "Enter Round Name",
                    labeltext: "Round words",
                    //iconData: Icons.lock_outlined,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButtonAuth(
                    text: "delete",
                    onPush: () {
                      controller.deleteRound();
                    },
                  ),
                ]))));
  }
}
