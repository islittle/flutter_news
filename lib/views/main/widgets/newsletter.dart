import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/components/index.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/utils/index.dart';

/// 邮件订阅
Widget newsletterWidget() {
  //email控制器
  final TextEditingController _emailController = TextEditingController();

  return Container(
    margin: EdgeInsets.all(duSetWidth(20)),
    child: Column(
      children: <Widget>[
        // newsletter
        Row(
          children: <Widget>[
            Text(
              'Newsletter',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: duSetFontSize(18),
                fontWeight: FontWeight.w600,
                color: ThemeColors.thirdElement,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.close,
                color: ThemeColors.thirdElementText,
                size: duSetFontSize(17),
              ),
              onPressed: () {},
            ),
          ],
        ),

        // email
        inputEmailEdit(
          marginTop: 19,
          keyboardType: TextInputType.emailAddress,
          hintText: "Email",
          isPassword: false,
          controller: _emailController,
        ),

        // btn subcrible
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: btnFlatButtonWidget(
            onPressed: () {},
            width: duSetWidth(335),
            height: duSetHeight(44),
            fontWeight: FontWeight.w600,
            title: "Subscribe",
          ),
        ),

        // disc
        Container(
          margin: EdgeInsets.only(top: duSetHeight(29)),
          width: duSetWidth(261),
          child: Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
              text: 'By clicking on Subscribe button you agree to accept',
              style: TextStyle(
                color: ThemeColors.thirdElementText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w400,
                fontSize: duSetFontSize(14),
              ),
            ),
            TextSpan(
              text: ' Privacy Policy',
              style: TextStyle(
                color: ThemeColors.secondaryElementText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w400,
                fontSize: duSetFontSize(14),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  toastInfo(message: 'Privacy Policy');
                },
            ),
          ])),
        ),
      ],
    ),
  );
}
