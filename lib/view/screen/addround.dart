import 'package:flutter/material.dart';
import 'package:game2/controller/addround_controller.dart';
import 'package:game2/core/constants/color.dart';
import 'package:game2/core/functions/validinput.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/auth/customtextformauth.dart';
import 'package:get/get.dart';

class AddRound extends StatelessWidget {
  const AddRound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.white,
          elevation: 0.0,
          title: Text('AddRound',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColor.gray)),
        ),
        body: GetBuilder<AddRoundControllerimp>(
            init: AddRoundControllerimp(),
            builder: (controller) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ListView(children: [
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 1, 100, "Round name");
                    },
                    mycontoller: controller.roundname,
                    hintText: "Enter Round Name",
                    labeltext: "round name",
                    //iconData: Icons.lock_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 1, 100, "word");
                    },
                    mycontoller: controller.words,
                    hintText: "Enter word",
                    labeltext: "word",
                    //  iconData: Icons.lock_outlined,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButtonAuth(
                    text: "Add",
                    onPush: () {
                      // controller.Delete();
                    },
                  ),
                ]))));
  }
}
