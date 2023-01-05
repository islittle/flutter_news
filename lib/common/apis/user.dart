import 'package:flutter/material.dart';
import 'package:flutter_news/utils/index.dart';
import 'package:flutter_news/common/entities/index.dart';

class UserAPI {
  // 登录
  static Future<UserLoginResponseEntity> login(
      {required BuildContext context,
      required UserLoginRequestEntity params}) async {
    var response =
        await R.post('/user/login', context: context, params: params);
    return UserLoginResponseEntity.fromJson(response);
  }
}
