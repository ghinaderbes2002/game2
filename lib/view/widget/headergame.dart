import 'package:flutter/material.dart';

class headergame extends StatelessWidget {
  final String text;
  final String text2;
  final String text3;
  final IconButton? iconButton;
  final IconData? icons;
  final void Function()? onTap;
  const headergame({
    Key? key,
    required this.text,
    required this.text2,
    required this.text3,
    this.iconButton,
    this.icons,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListTile(
      title: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          Text(
            text2,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          Text(
            text3,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
      trailing: iconButton,
      onTap: onTap,
    ));
  }
}
