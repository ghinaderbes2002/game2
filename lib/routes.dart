import 'package:game2/core/constants/routes.dart';
import 'package:game2/core/middleware/myMiddleware.dart';
import 'package:game2/view/screen/addround.dart';
import 'package:game2/view/screen/auth/login.dart';
import 'package:game2/view/screen/auth/signup.dart';
import 'package:game2/view/screen/deleteround.dart';
import 'package:game2/view/screen/updateround.dart';
import 'package:game2/view/screen/home.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/", page: () => const Login(), middlewares: [MyLoginMiddleware()]),
  GetPage(name: AppRoute.signUp, page: () => const SigUp()),
  GetPage(name: AppRoute.login, page: () => const Home()),
  GetPage(name: AppRoute.deleteround, page: () => const DeleteRound()),
  GetPage(name: AppRoute.exitround, page: () => const Updateround()),
  GetPage(name: AppRoute.addround, page: () => const AddRound()),
];
