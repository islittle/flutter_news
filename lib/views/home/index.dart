import 'package:flutter/material.dart';
import 'package:flutter_news/global.dart';
import 'package:flutter_news/views/application/index.dart';
import 'package:flutter_news/views/signin/index.dart';
import 'package:flutter_news/views/welcome/welcome.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812 - 44 - 34));
    return Scaffold(
      body: Global.isFirstOpen == true
          ? const WelcomePage()
          : Global.isOfflineLogin == true
              ? const ApplicationPage()
              : const SignInPage(),
    );
  }
}
