import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news/common/entities/index.dart';
import 'package:flutter_news/store/index.dart';
import 'package:flutter_news/utils/index.dart';
import 'package:flutter_news/common/consts/index.dart';

/// 全局配置
class Global {
  /// 用户配置
  static UserLoginResponseEntity profile = UserLoginResponseEntity(
    accessToken: '',
  );

  static bool isFirstOpen = false;

  static bool isOfflineLogin = false;

  static AppState appState = AppState();

  /// 是否 release
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 工具初始
    await Storage.init();
    Request();

    // 读取设备是否第一次打开
    isFirstOpen = !Storage().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);

    if (isFirstOpen) {
      Storage().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }
    //Storage().remove(STORAGE_USER_PROFILE_KEY);
    // 读取离线用户信息
    var _profileJSON = Storage().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserLoginResponseEntity.fromJson(_profileJSON);
      isOfflineLogin = true;
    }

    // http 缓存
    // statusBarColor只能在 Android 中更改，而不能在 iOS 中更改，如果您尝试通过某些解决方法尝试这样做，Apple 可能会拒绝您的应用程序，因为他们不希望您拥有不同的AppBar状态栏颜色。
    // android 状态栏为透明的沉浸
//    if (Platform.isAndroid) {
//      SystemUiOverlayStyle systemUiOverlayStyle =
//          const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
//      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//    } else {
      SystemUiOverlayStyle dark = const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF000000),
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
      SystemChrome.setSystemUIOverlayStyle(dark);
//      AppBar(backgroundColor: Colors.black); // this changes both AppBar and status bar color in iOS
//    }
  }

  // 持久化 用户信息
  static Future<bool> saveProfile(UserLoginResponseEntity userResponse) async {
    profile = userResponse;
    return await Storage()
        .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }
}
