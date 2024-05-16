import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:game2/binding.dart';
import 'package:game2/routes.dart';
import 'package:get/get.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialBinding: MyBinding(),
      getPages: routes,
    );
  }
}
