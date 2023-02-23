import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilServices {
  // R$ valor

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(
      locale: 'pt_BR',
    );
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime, String locale) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd(locale).add_Hm();
    return dateFormat.format(dateTime);
  }

  void showToast({
    required String message,
    bool isError = false,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor:
          isError ? Colors.red : const Color.fromARGB(255, 134, 207, 136),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
