import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext? context,
    required ContentType contentType,
    required String title,
    required String body}) {
  final snackBar = SnackBar(
    content: AwesomeSnackbarContent(
      title: title,
      message: body,
      contentType: contentType,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context!)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
