import 'package:flutter/material.dart';

import '../../../core/constants/values/app_colors.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPush;
  Color? buttonColor;

  CustomButtonAuth(
      {super.key, required this.text, this.onPush, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.defaultGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 30),
        onPressed: onPush,
        color: buttonColor ?? AppColors.darkBlue,
        textColor: Colors.white,
        child: Text(text),
      ),
    );
  }
}
