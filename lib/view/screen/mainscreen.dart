import 'package:flutter/material.dart';
import 'package:game2/controller/main_controller.dart';
import 'package:game2/core/constants/color.dart';
import 'package:game2/view/widget/navigationbar.dart';
import 'package:get/get.dart';

class MainScreen extends GetView<MainControllerimp> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MainControllerimp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        elevation: 0.0,
        title: Text('MainScrean',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.gray)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: controller.screens[controller.currentScreen],
      ),
      floatingActionButton: PageFooter(
        iconData: Icons.home_filled,
        iconData2: Icons.menu,
        iconData3: Icons.person,
        color: Colors.orange,
        onTap: (index) {
          controller.changePage(index);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
