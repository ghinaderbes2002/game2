import 'package:flutter/material.dart';
import 'package:game2/controller/round_controller.dart';
import 'package:game2/view/widget/roundswidget.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../model/round_model.dart';

class Rounds extends GetView<RoundControllerImp> {
  const Rounds({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RoundControllerImp());
    return FutureBuilder<List<RoundModel>>(
      future: controller.getRounds(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<RoundModel> rounds = snapshot.data!;
          print(
              "*-+-*-+-*-+-\n\n\n\n\n\n\n\n\n\n  ${controller.userModel.getLogWithHighestScore(8)?.score}  \n\n\n\n\n\n\n\n\n*-++-*-+-*-+-*-");

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: ListView.separated(
              itemCount: rounds.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 15,
              ),
              itemBuilder: (BuildContext context, int index) {
                print(
                    "qqqqqqqqqqqqq\n\n\n\n\n\n\n\n ${controller} \n\n\n\n\n\n\n\n11111111111111");
                bool isRoundNameMatch(
                    List<RoundModel> roundModels, String roundName) {
                  return roundModels.any((round) => round.name == roundName);
                }

                return RoundsWidget(
                  icon: Ionicons.rocket_outline,
                  text: rounds[index].name,
                  text2: "Has ${rounds[index].words.length} words\t\t\t",
                  text3: "",
                  logModel: controller.userModel
                      .getLogWithHighestScore(rounds[index].id),
                  isPlayed: isRoundNameMatch(
                          controller.openRounds, rounds[index].name) ||
                      index == 0,
                  round: rounds[index],
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}