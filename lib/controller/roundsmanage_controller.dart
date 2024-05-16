import 'package:game2/view/screen/addround.dart';
import 'package:game2/view/screen/deleteround.dart';
import 'package:game2/view/screen/updateround.dart';
import 'package:get/get.dart';

abstract class RoundsManageController extends GetxController {
  Add();
  Exit();
  Delete();
}

class RoundsManageControllerimp extends RoundsManageController {
  @override
  Add() {
    Get.offAll(() => const AddRound());
  }

  @override
  Exit() {
    Get.offAll(() => const Updateround());
  }

  @override
  Delete() {
    Get.offAll(() => const DeleteRound());
  }
}
