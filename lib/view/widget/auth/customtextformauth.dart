import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hintText;
  final String labeltext;
  final IconData? iconData;
  final TextEditingController? mycontoller;
  final String? Function(String?)? valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final Function(String)? onChanged;
  const CustomTextFormAuth({
    Key? key,
    required this.hintText,
    required this.labeltext,
    this.iconData,
    required this.mycontoller,
    required this.valid,
    required this.isNumber,
    this.obscureText,
    this.onTapIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          print(value);
        },
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        obscureText: obscureText == null || obscureText == false ? false : true,
        controller: mycontoller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(labeltext)),
            suffixIcon: InkWell(
              child: Icon(iconData),
              onTap: onTapIcon,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
