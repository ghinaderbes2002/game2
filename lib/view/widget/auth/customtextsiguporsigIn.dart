import 'package:flutter/material.dart';
import 'package:game2/core/constants/color.dart';

class CustomTextSigUpOrSigIn extends StatelessWidget {
  final String textone;
  final String texttwo;
  final void Function() onTap;
  const CustomTextSigUpOrSigIn({
    Key? key,
    required this.textone,
    required this.texttwo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textone),
        InkWell(
          onTap: onTap,
          child: Text(
            texttwo,
            style: const TextStyle(
                color: AppColor.orange, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
