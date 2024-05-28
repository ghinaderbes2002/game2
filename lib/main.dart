import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:game2/binding.dart';
import 'package:game2/core/services/services.dart';
import 'package:game2/routes.dart';
import 'package:get/get.dart';

import 'core/constants/values/app_theme.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await initializeServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      initialBinding: MyBinding(),
      getPages: routes,
    );
  }
}
