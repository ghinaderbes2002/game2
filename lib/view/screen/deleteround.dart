import 'package:flutter/material.dart';
import 'package:game2/controller/deleteround_controller.dart';
import 'package:game2/core/constants/color.dart';
import 'package:game2/core/functions/validinput.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/auth/customtextformauth.dart';
import 'package:get/get.dart';

class DeleteRound extends StatelessWidget {
  const DeleteRound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.white,
          elevation: 0.0,
          title: Text('DeleteRound',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColor.gray)),
        ),
        body: GetBuilder<DeleteRoundControllerimp>(
            init: DeleteRoundControllerimp(),
            builder: (controller) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ListView(children: [
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 1, 100, "round word");
                    },
                    mycontoller: controller.chooseRound,
                    hintText: "Enter ",
                    labeltext: "Round words",
                    //iconData: Icons.lock_outlined,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButtonAuth(
                    text: "delete",
                    onPush: () {
                      // controller.Delete();
                    },
                  ),
                ]))));
  }
}
