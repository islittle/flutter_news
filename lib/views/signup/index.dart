import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/components/index.dart';
import 'package:flutter_news/utils/index.dart';
import 'package:flutter_news/widgets/buildThirdPartyLogin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // fullName email password 的控制器
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // logo
  Widget _buildLogo(context) {
    // 中文注释
    var arguments = ModalRoute.of(context)?.settings.arguments;

    return Container(
      margin: EdgeInsets.only(top: duSetHeight(50)),
      child: TextButton(
        onPressed: () {
          toastInfo(message: "$arguments");
        },
        child: Text(
          "注册",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.primaryText,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: duSetFontSize(24),
            height: 1,
          ),
        ),
      ),
    );
  }

  // 注册表单
  Widget _buildInputForm() {
    return Container(
      width: duSetWidth(295),
      // height: 204,
      margin: EdgeInsets.only(top: duSetHeight(49)),
      child: Column(
        children: [
          // fullName input
          inputTextEdit(
            controller: _fullnameController,
            keyboardType: TextInputType.text,
            hintText: "用户名",
            marginTop: 0,
          ),
          // email input
          inputTextEdit(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "邮箱",
          ),
          // password input
          inputTextEdit(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "密码",
            isPassword: true,
          ),

          // 创建
          Container(
            height: duSetHeight(44),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: btnFlatButtonWidget(
              onPressed: () {
                if (!duCheckStringLength(_fullnameController.value.text, 5)) {
                  toastInfo(message: '用户名不能小于5位');
                  return;
                }
                if (!duIsEmail(_emailController.value.text)) {
                  toastInfo(message: '请正确输入邮件');
                  return;
                }
                if (!duCheckStringLength(_passwordController.value.text, 6)) {
                  toastInfo(message: '密码不能小于6位');
                  return;
                }
                Navigator.pop(context);
              },
              width: 295,
              fontWeight: FontWeight.w600,
              title: "注册",
            ),
          ),
          // Spacer(),

          // Fogot password
          Container(
            height: duSetHeight(22),
            margin: EdgeInsets.only(top: duSetHeight(20)),
            child: TextButton(
              onPressed: () => {},
              child: Text(
                "忘记密码？",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: ThemeColors.secondaryElementText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  fontSize: duSetFontSize(16),
                  height: 1, // 设置下行高，否则字体下沉
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 有账号
  Widget _buildHaveAccountButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: btnFlatButtonWidget(
        onPressed: () {
          Navigator.pop(context,'我是来自signUpPage页面的回调函数参数');
        },
        width: 294,
        gbColor: ThemeColors.transparent,
        fontColor: ThemeColors.primaryText,
        title: "有账号，去登录",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: ThemeColors.primaryText,
            ),
            onPressed: () {
              toastInfo(message: "提示文案");
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ThemeColors.primaryText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
//        height: 44,
      ),
      body: Center(
        child: Column(
          children: [
            const Divider(
              height: 1,
            ),
            _buildLogo(context),
            _buildInputForm(),
            const Spacer(),
            buildThirdPartyLogin(),
            _buildHaveAccountButton(),
          ],
        ),
      ),
    );
  }
}
