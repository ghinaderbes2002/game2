import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game2/controller/round_controller.dart';
import 'package:game2/core/constants/values/app_colors.dart';
import 'package:game2/model/log_model.dart';
import 'package:get/get.dart';

import '../../model/round_model.dart';
import '../screen/gamescreen.dart';

class RoundsWidget extends GetView<RoundControllerImp> {
  final String text;
  final String? text2;
  final String? text3;
  final IconData? iconData;
  final IconData? icon;
  final bool isPlayed;
  final LogModel? logModel;
  final void Function()? onTap;
  RoundModel round;

  RoundsWidget({
    super.key,
    required this.text,
    this.text2,
    this.text3,
    this.iconData,
    this.icon,
    this.onTap,
    required this.isPlayed,
    this.logModel,
    required this.round,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(RoundControllerImp());
    return ListTile(
      tileColor: isPlayed ? AppColors.darkPrimaryColor : AppColors.primaryColor,
      textColor: Colors.white,
      leading: Icon(icon),
      title: Text(text),
      subtitle: Row(
        children: <Widget>[
          Text(
            text2!,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          if (isPlayed)
            Text(
              "Score: ",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          Text(
            isPlayed ? (logModel?.score.toString() ?? "0") : text3!,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
      trailing:
          isPlayed ? const Icon(Icons.play_arrow) : const Icon(Icons.lock),
      onTap: () => isPlayed
          ? {
              controller.myServices.sharedPreferences
                  .setString("selectedRound", jsonEncode(round.toJson())),
              Get.to(() => GameScreen()),
            }
          : {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
