// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/components/index.dart';
import 'package:flutter_news/utils/index.dart';

Widget buildThirdPartyLogin() {
  return Container(
    width: duSetWidth(295),
    margin: EdgeInsets.only(bottom: duSetHeight(40)),
    child: Column(
      children: <Widget>[
        // title
        Text(
          "其他方式",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.primaryText,
            fontFamily: "Avenir",
            fontWeight: FontWeight.w400,
            fontSize: duSetFontSize(16),
          ),
        ),
        // 按钮
        Padding(
          padding: EdgeInsets.only(top: duSetHeight(20)),
          child: Row(
            children: <Widget>[
              btnFlatButtonBorderOnlyWidget(
                onPressed: () {},
                width: 88,
                iconFileName: "twitter",
              ),
              const Spacer(),
              btnFlatButtonBorderOnlyWidget(
                onPressed: () {},
                width: 88,
                iconFileName: "google",
              ),
              const Spacer(),
              btnFlatButtonBorderOnlyWidget(
                onPressed: () {},
                width: 88,
                iconFileName: "facebook",
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
