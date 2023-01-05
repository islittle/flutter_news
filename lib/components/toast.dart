import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_news/utils/index.dart';

Future<bool?> toastInfo(
    {required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    double fontSize = 16}) async {
  return await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: duSetFontSize(fontSize));
}
