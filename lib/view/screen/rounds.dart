import 'package:flutter/material.dart';
import 'package:game2/controller/round_controller.dart';
import 'package:game2/view/widget/roundswidget.dart';
import 'package:get/get.dart';

class Rounds extends GetView<RoundControllerimp> {
  const Rounds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: ListView.separated(
        itemCount: controller.rounds.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 15,
        ),
        itemBuilder: (BuildContext context, int index) {
          return RoundsWidget(
            text: controller.rounds[index].name,
            isPlayed: controller.isRoundPlayed(controller.rounds[index].id),
            logModel: controller.getLogFromId(controller.rounds[index].id),
            onTap: () {
              controller.selecteRound = controller.rounds[index];
            },
          );
        },
      ),
    ));
  }
}
