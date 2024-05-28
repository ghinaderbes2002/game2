import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game2/controller/game_controller.dart';
import 'package:game2/core/constants/values/app_colors.dart';
import 'package:game2/main.dart';
import 'package:game2/view/widget/auth/custombuttonauth.dart';
import 'package:game2/view/widget/headergame.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class GameScreen extends StatefulWidget {
  GameScreen({
    super.key,
  });

  @override
  State<GameScreen> createState() => _GameState();
}

class _GameState extends State<GameScreen> {
  late CameraController cameraController;
  CameraImage? img;
  bool isBusy = false;
  String result = "";
  dynamic imageLabeler;

  @override
  void initState() {
    super.initState();
    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.75);
    imageLabeler = ImageLabeler(options: options);
    cameraController = CameraController(cameras![0], ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.nv21);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      cameraController.startImageStream((image) => {
            if (!isBusy) {isBusy = true, img = image, doImageLabeling()}
          });
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  doImageLabeling() async {
    result = "";
    InputImage? inputImg = getInputImage();
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImg);
    for (ImageLabel label in labels) {
      final String text = label.label;
      final int index = label.index;
      final double confidence = label.confidence;
      result += "${text.toLowerCase()},";
    }
    setState(() {
      result;
      isBusy = false;
    });
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? getInputImage() {
    final camera = cameras![1];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[cameraController.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(img!.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21)) return null;

    if (img?.planes.length != 1) return null;
    final plane = img?.planes.first;

    return InputImage.fromBytes(
      bytes: plane!.bytes,
      metadata: InputImageMetadata(
        size: Size(img!.width.toDouble(), img!.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: GetBuilder<GameControllerImp>(
          init: GameControllerImp(),
          builder: (controller) {
            controller.checkLabels(result);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => GameHeader(text: """Time: ${controller.seconds.obs}
                      \t\t""", text2: """Mistakes: ${controller.mistake}/3
                        \t\t\t""", text3: """Score: ${controller.score}
                          """),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: AppColors.darkBlue,
                    elevation: 5,
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller
                                .currentRound.words[controller.wordIndex].word,
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: CameraPreview(cameraController),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButtonAuth(
                    text: controller.isPaused ? "Resume" : "Pause",
                    buttonColor: AppColors.darkPrimaryColor,
                    onPush: () => controller.isPaused
                        ? controller.resumeRound()
                        : controller.pauseRound(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
