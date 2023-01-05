import 'package:flutter_news/views/account/index.dart';
import 'package:flutter_news/views/application/index.dart';
import 'package:flutter_news/views/bookmarks/index.dart';
import 'package:flutter_news/views/category/index.dart';
import 'package:flutter_news/views/main/index.dart';

import 'package:flutter_news/views/signin/index.dart';
import 'package:flutter_news/views/signup/index.dart';

var staticRoutes = {
  "/signin": (context) => const SignInPage(), // 登录
  "/signup": (context) => const SignUpPage(), // 注册
  "/app": (context) => const ApplicationPage(),
  "/account": (context) => const AccountPage(),
  "/bookmarks": (context) => const BookmarksPage(),
  "/category": (context) => const CategoryPage(),
  "/main": (context) => const MainPage()
};
