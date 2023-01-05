import 'package:flutter/material.dart';
import 'package:flutter_news/router/index.gr.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/utils/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  /// 页头标题
  Widget _buildPageHeaderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 60.h),
      child: Text(
        "Features",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ThemeColors.primaryText,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: 24.sp),
      ),
    );
  }

  /// 页头说明
  Widget _buildPageHeaderDetail() {
    return Container(
      width: 242.w,
      height: 70.h,
      margin: EdgeInsets.only(top: 14.h),
      child: Text(
        "The best of news channels all in one place. Trusted sources and personalized news for you.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeColors.primaryText,
          fontFamily: "Avenir",
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
          height: 1.3,
        ),
      ),
    );
  }

  /// 特性说明
  /// 宽度 80 + 20 + 195 = 295
  Widget _buildFeatureItem(String imageName, String intro, double marginTop) {
    return Container(
      width: 295.w,
      height: 80.h,
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            height: 80.h,
            child: Image.asset(
              "assets/images/$imageName.png",
              fit: BoxFit.none,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 195.w,
            child: Text(
              intro,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: ThemeColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 开始按钮
  Widget _buildStartButton() {
    return Container(
      width: 295.w,
      height: 44.h,
      margin: EdgeInsets.only(bottom: 20.h),
      child: TextButton(
        //color: ThemeColors.primaryElement,
        //textColor: ThemeColors.primaryElementText,
        child: const Text(
          "Get started",
          style: TextStyle(
            color: ThemeColors.primaryElementText,
          ),
        ),
        onPressed: () {
          router(context).push(const SignInRoute());
          //Navigator.pushNamed(context, '/signin');
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(ThemeColors.primaryElement),
          //圆角
          shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(borderRadius: Radii.k6pxRadius)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _buildPageHeaderTitle(),
            _buildPageHeaderDetail(),
            _buildFeatureItem(
              "feature-1",
              "Compelling photography and typography provide a beautiful reading",
              86.h,
            ),
            _buildFeatureItem(
              "feature-2",
              "Sector news never shares your personal data with advertisers or publishers",
              40.h,
            ),
            _buildFeatureItem(
              "feature-3",
              "You can get Premium to unlock hundreds of publications",
              40.h,
            ),
            const Spacer(),
            _buildStartButton(),
          ],
        ),
      ),
    );
  }
}
