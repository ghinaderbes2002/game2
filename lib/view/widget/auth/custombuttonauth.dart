import 'package:flutter/material.dart';
import 'package:game2/core/constants/color.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPush;
  const CustomButtonAuth({Key? key, required this.text, this.onPush})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 13),
        onPressed: onPush,
        color: AppColor.orange,
        textColor: Colors.white,
        child: Text(text),
      ),
    );
  }
}
