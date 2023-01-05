import 'package:flutter/material.dart';
import 'package:flutter_news/common/consts/index.dart';
import 'package:flutter_news/common/entities/user.dart';
import 'package:flutter_news/global.dart';
import 'package:flutter_news/router/index.gr.dart';
import 'package:flutter_news/utils/index.dart';

/// 检查是否有 token
Future<bool> isAuthenticated() async {
  var profileJSON = Storage().getJSON(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

/// 删除缓存 token
Future deleteAuthentication() async {
  await Storage().remove(STORAGE_USER_PROFILE_KEY);
  Global.profile = UserLoginResponseEntity(
    accessToken: '',
  );
}

/// 重新登录
Future goLoginPage(BuildContext context) async {
  await deleteAuthentication();

  router(context).push(const SignInRoute());
  // Navigator.pushNamedAndRemoveUntil(
  //     context, "/signin", (Route<dynamic> route) => false);
}
