import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void SnackBarWidget({
  BuildContext? context,
  String? message,
  Color? color,
  SnackBarBehavior? behavior,
  Color? actionLabelColor,
}) {
  final snackBar = SnackBar(
    content: Text(message!),
    backgroundColor: color,
    behavior: behavior,
    width: MediaQuery.of(context!).size.width,
    duration: const Duration(seconds: 1),
    elevation: 30,
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: actionLabelColor,
      onPressed: () {
        //Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
