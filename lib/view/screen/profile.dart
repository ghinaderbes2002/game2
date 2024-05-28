import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:game2/controller/profile_controller.dart';
import 'package:game2/core/constants/values/app_colors.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileControllerImp>(
        init: ProfileControllerImp(),
        builder: (controller) => ListView(
              children: [
                BigUserCard(
                  backgroundColor: AppColors.primaryColor,
                  userProfilePic: const AssetImage(
                    "assets/images/profile.png",
                  ),
                  userName:
                      "${controller.userModel.name}\nHigh Score : ${controller.highScore}",
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => const AlertDialog(
                          title: Text('About Capty'),
                          content: Text('''
          The game is about finding the element written on the screen as quickly as possible. There is a limited time to find it using the mobile device's camera. The app recognizes the element the camera is pointed at using a real-time image classification system and verifies its correctness.

          The app allows users to create an account via a website (username and password). Once registered, users can create a new game and start playing. The game consists of multiple stages, each with specific conditions that include score targets, time limits, and a permissible number of mistakes.

          Users can pause the game and view their scores in each game to resume later. The app celebrates the "Player of the Week" by showcasing the player with the highest score among all players on the main interface.

          Enjoy the challenge and compete to find the elements as quickly as possible and become the top player!'''),
                        ),
                      ),
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'About',
                      subtitle: "Learn more about Capty App",
                    ),
                  ],
                ),
                // You can add a settings title
                SettingsGroup(
                  settingsGroupTitle: "Account",
                  items: [
                    SettingsItem(
                      onTap: () {
                        controller.signOut();
                      },
                      icons: Icons.exit_to_app_rounded,
                      title: "Sign Out",
                    ),
                  ],
                ),
              ],
            ));
  }
}
