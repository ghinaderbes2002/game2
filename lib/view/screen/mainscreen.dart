import 'package:flutter/material.dart';
import 'package:game2/controller/main_controller.dart';
import 'package:game2/view/screen/rounds_manage/roundsmanage.dart';
import 'package:game2/view/widget/navigationbar.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/constants/values/app_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainControllerImp>(
        init: MainControllerImp(),
        builder: (controller) {
          print(
              "is admin ?  ${controller.myServices.sharedPreferences.getBool("isAdmin")}");
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 600,
              leading: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                child: const Text(
                  "Capty",
                  style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
              backgroundColor: Colors.white,
              actions: [
                if (controller.myServices.sharedPreferences
                        .getBool("isAdmin") ??
                    false)
                  IconButton(
                    onPressed: () {
                      Get.to(() => const RoundsManage());
                    },
                    icon: const Icon(
                      Ionicons.game_controller_outline,
                      color: AppColors.darkBlue,
                      size: 32,
                    ),
                  ),
              ],
            ),
            body: SafeArea(
              child: Container(
                // decoration: BoxDecoration(
                //   image: DecorationImage(image: AssetImage("assets/images/home_bg.jpg"),fit: BoxFit.cover)
                // ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: controller.screens[controller.currentScreen],
              ),
            ),
            floatingActionButton: PageFooter(
              iconData: Icons.home_filled,
              iconData2: Icons.menu,
              iconData3: Icons.person,
              color: AppColors.primaryColor,
              onTap: (index) {
                print(index);
                controller.changePage(index);
              },
              pageIndex: controller.currentScreen,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}
