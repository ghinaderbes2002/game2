import 'package:flutter/material.dart';
import 'package:game2/controller/round_controller.dart';
import 'package:game2/model/log_model.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class RoundsWidget extends GetView<RoundControllerimp> {
  final String text;
  final String? text2;
  final String? text3;
  final IconData? iconData;
  final IconData? icon;
  final bool isPlayed;
  final LogModel logModel;
  final void Function()? onTap;
  const RoundsWidget(
     {
    Key? key,
    required this.text,
    this.text2,
    this.text3,
    this.iconData,
    this.icon,
    this.onTap,
    required this.isPlayed,required this.logModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListTile(
      leading: Icon(icon),
      title: Text(text),
      subtitle: Row(
        children: <Widget>[
          Text(
            text2!,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          Text(
            text3!,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
      trailing: isPlayed ? Text(logModel.score.toString()) : Icon(Icons.lock),
      onTap: onTap,
    ));
  }
}
