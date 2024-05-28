import 'package:flutter/material.dart';
import 'package:game2/core/constants/values/app_colors.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class BoxText extends StatelessWidget {
  final String text;
  final String? text2;
  final String? text3;
  final IconData? iconData;
  const BoxText({
    Key? key,
    required this.text,
    this.text2,
    this.text3,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TapToExpand(
        backgroundcolor: AppColors.primaryColor,
        content: Column(
          children: <Widget>[
            Text(
              text2 ?? "",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              text3 ?? "",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        title: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        closedHeight: 70,
        openedHeight: 150,
      ),
    );
  }
}
