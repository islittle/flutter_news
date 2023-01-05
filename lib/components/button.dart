import 'package:flutter/material.dart';
import 'package:flutter_news/utils/index.dart';
import 'package:flutter_news/styles/index.dart';

Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color gbColor = ThemeColors.primaryElement,
  String title = "button",
  Color fontColor = ThemeColors.primaryElementText,
  double fontSize = 18,
  String fontName = "Montserrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return SizedBox(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(gbColor),
        //圆角
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: Radii.k6pxRadius)),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: fontColor,
            fontFamily: fontName,
            fontWeight: fontWeight,
            fontSize: duSetFontSize(fontSize),
            height: 1),
      ),
    ),
  );
}

Widget btnFlatButtonBorderOnlyWidget({
  required VoidCallback onPressed,
  double width = 88,
  double height = 44,
  required String iconFileName,
}) {
  return Container(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        //圆角
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: Radii.k6pxRadius)),
        //边框
        side: MaterialStateProperty.all(Borders.primaryBorder),
      ),
      child: Image.asset(
        "assets/images/icons-$iconFileName.png",
      ),
    ),
  );
}
