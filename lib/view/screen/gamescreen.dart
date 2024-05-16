import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:game2/controller/game_controller.dart';
import 'package:game2/main.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/boxtext.dart';
import 'package:game2/view/widget/headergame.dart';
import 'package:get/get.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameState();
}

class _GameState extends State<GameScreen> {
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras![0], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispoe() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }
    return Column(children: [
      Scaffold(
          body: GetBuilder<GameControllerimp>(
              init: GameControllerimp(),
              builder: (controller) => Container(
                      child: ListView(children: [
                    headergame(
                        text: 'time : ${Obx(() => Text(
                              'Seconds:${controller.seconds}',
                            ))}',
                        text2: 'score :',
                        text3: 'mistakes :',
                        iconButton: controller.isPaused
                            ? IconButton(
                                onPressed: () => controller.resumeRound(),
                                icon: Icon(Icons.play_arrow))
                            : IconButton(
                                onPressed: () => controller.pauseRound(),
                                icon: Icon(Icons.pause))),
                    const SizedBox(
                      height: 30,
                    ),
                    BoxText(
                      text: controller.currentWord,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CameraPreview(cameraController),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonAuth(
                      text: "take",
                      onPush: () {
                        //  controller.Login();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]))))
    ]);
  }
}
