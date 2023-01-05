import 'package:flutter/material.dart';
import 'package:flutter_news/global.dart';
import 'package:flutter_news/router/index.gr.dart';
import 'package:flutter_news/views/signup/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/components/index.dart';
import 'package:flutter_news/utils/index.dart';
// import 'package:flutter_news/common/apis/index.dart';
import 'package:flutter_news/common/entities/index.dart';

import '../../common/apis/user.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //email控制器
  final TextEditingController _emailController = TextEditingController();

  // 密码控制器
  final TextEditingController _passwordController = TextEditingController();

  // 跳转 注册界面
  /// @description
  /// @param 
  /// @return 
  /// @author 王峰
  /// @time 11/15/22 11:42 AM
  _handleNavSignUp() async {
//    push跳转
//    router(context).push(const SignUpPage());
//    跳转–命名路由Navigator.pushNamed，需要配合路由表在main.dart中
//    如果是非autoRouter的话，routes里面需要设置一下别称 "/signup": (context) => SignUpPage()
//    如果是autoRouter的话, 查看是否自定义，自定义的话用自定义的，没自定义的话查看一下router里面生成的*.gr.dark文件，对应的页面的path
//    router(context).pushNamed(
//      "/signup"
//    );
//   常规跳转，没有携带参数
//    Navigator.push(context, MaterialPageRoute(builder: (context){
//      return const SignUpPage();
//    }));
//    跳转–Navigator.push+参数
    var callBackReturn = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context){
        return const SignUpPage();
      },
          settings: const RouteSettings(arguments: '我是来自signInPage页面的参数'),
      )
    );
    // ignore: avoid_print
    print('debug: $callBackReturn');
  }

  // 执行登录操作
  _handleSignIn() async {
    if (!duIsEmail(_emailController.value.text)) {
      toastInfo(message: '请正确输入邮件');
      return;
    }
    if (!duCheckStringLength(_passwordController.value.text, 6)) {
      toastInfo(message: '密码不能小于6位');
      return;
    }

    UserLoginRequestEntity params = UserLoginRequestEntity(
      email: _emailController.value.text,
      password: duSHA256(_passwordController.value.text),
    );
    UserLoginResponseEntity userProfile =
        await UserAPI.login(context: context, params: params);

//    toastInfo(message: userProfile.toJson().toString());
    Global.saveProfile(userProfile);

    router(context).push(const ApplicationRoute());
    // Navigator.pushNamed(context, '/app');
    // 写本地 access_token , 不写全局，业务：离线登录
    // 全局数据 gUser
  }

  /// logo
  Widget _buildLogo() {
    return Container(
//      width: 110.w,
      margin: EdgeInsets.only(top: 88.h),
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 76.w,
            height: 76.h,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 76.h,
                    decoration: BoxDecoration(
                      color: ThemeColors.primaryBackground,
                      boxShadow: const [Shadows.primaryShadow],
                      borderRadius:
                          BorderRadius.all(Radius.circular(38.w)), // 父容器50%
                    ),
                    child: Container(),
                  ),
                ),
                Positioned(
                  top: 13.w,
                  child: Image.asset(
                    "assets/images/logo.jpg",
                    fit: BoxFit.fitHeight,
                    width: 62.w,
                    height: 62.w,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h),
            child: Text(
              "hot",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.primaryText,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                height: 1,
              ),
            ),
          ),
          Text(
            "Latest news, updated continuously~",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// 登录表单
  Widget _buildInputForm() {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(top: duSetHeight(25)),
      child: Column(
        children: [
          // email input
          inputTextEdit(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "请输入用户名",
            marginTop: 0,
          ),
          // password input
          inputTextEdit(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "请输入密码",
            isPassword: true,
          ),
          Container(
//            height: duSetHeight(44),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: btnFlatButtonWidget(
              width: double.infinity,   //设置宽高最大
              onPressed: () => _handleSignIn(),
              gbColor: ThemeColors.primaryElement,
              title: "登录",
            ),
          ),

          Container(
            height: 22.h,
            margin: EdgeInsets.only(top: 20.h),
            child: TextButton(
              onPressed: () {
                toastInfo(message: "啥也没有那，点了也没用");
              },
              child: Text(
                "忘记密码?",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: ThemeColors.secondaryElementText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  height: 1, // 设置下行高，否则字体下沉
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: btnFlatButtonWidget(
        onPressed: _handleNavSignUp,
        width: 294,
        gbColor: ThemeColors.transparent,
        fontColor: ThemeColors.primaryText,
        title: "注册",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            _buildInputForm(),
            const Spacer(),
            _buildSignupButton()
          ],
        ),
      ),
    );
  }
}

class Routes {
}
