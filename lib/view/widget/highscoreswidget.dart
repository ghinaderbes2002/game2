import 'package:flutter/material.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class HighScoresWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const HighScoresWidget({Key? key, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TapToExpand(
        content: Column(
          children: <Widget>[
            for (var i = 0; i < 20; i++)
              Text(
                "data $i",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
          ],
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        closedHeight: 70,
        openedHeight: 200,
      ),
    );
  }
}
