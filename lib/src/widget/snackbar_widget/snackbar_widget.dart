import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void SnackBarWidget({
  BuildContext? context,
  String? message,
  Color? color,
  Color? actionLabelColor,
  dynamic? animation,
}) {
  final snackBar = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    content: Text(
      message!,
      style: const TextStyle(
        fontSize: 12,
      ),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 10, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
    width: 280.0, // Width of the SnackBar.
    //margin: const EdgeInsets.fromLTRB(20, 100, 20, 0),
    animation: animation,
    duration: const Duration(seconds: 1),
    elevation: 30,
    action: SnackBarAction(
      label: 'Closed',
      disabledTextColor: Colors.white,
      textColor: actionLabelColor,
      onPressed: () {
        //Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}
