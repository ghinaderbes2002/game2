import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "not vaid username";
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "not vaid email";
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "not vaid phone";
    }
  }
  if (val.isEmpty) {
    return " can't be empty";
  }

  if (val.length < min) {
    return " can't be lass than $min";
  }
  if (val.length > max) {
    return " can't be larger than $max";
  }
}
