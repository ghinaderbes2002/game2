import 'package:game2/core/constants/routes.dart';
import 'package:game2/core/middleware/myMiddleware.dart';
import 'package:game2/view/screen/auth/screens/login_screen.dart';
import 'package:game2/view/screen/auth/screens/register_screen.dart';
import 'package:game2/view/screen/mainscreen.dart';
import 'package:game2/view/screen/rounds_manage/addround.dart';
import 'package:game2/view/screen/rounds_manage/deleteround.dart';
import 'package:game2/view/screen/rounds_manage/roundsmanage.dart';
import 'package:game2/view/screen/rounds_manage/updateround.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/",
      page: () => const LoginPage(),
      middlewares: [MyLoginMiddleware()]),
  GetPage(name: AppRoute.signUp, page: () => const RegisterPage()),
  GetPage(name: AppRoute.home, page: () => const MainScreen()),
  GetPage(name: AppRoute.manageRounds, page: () => const RoundsManage()),
  GetPage(name: AppRoute.deleteround, page: () => const DeleteRound()),
  GetPage(name: AppRoute.exitround, page: () => const Updateround()),
  GetPage(name: AppRoute.addround, page: () => const AddRound()),
];
