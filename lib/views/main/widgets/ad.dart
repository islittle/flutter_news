import 'package:flutter/material.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/utils/index.dart';

/// ad广告
Widget adWidget() {
  return Container(
    alignment: Alignment.center,
    height: duSetHeight(100),
    padding: EdgeInsets.all(duSetWidth(20)),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: duSetWidth(20)),
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(Borders.primaryBorder),
        borderRadius: Radii.k6pxRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tired of Ads? Get Premium - \$9.99",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              fontSize: duSetFontSize(18),
            ),
          ),
        ],
      ),
    ),
  );
}
