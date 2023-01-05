import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_news/views/account/index.dart';
import 'package:flutter_news/views/application/index.dart';
import 'package:flutter_news/views/bookmarks/index.dart';
import 'package:flutter_news/views/category/index.dart';
import 'package:flutter_news/views/details/index.dart';
import 'package:flutter_news/views/home/index.dart';
import 'package:flutter_news/views/main/index.dart';

import 'package:flutter_news/views/signin/index.dart';
import 'package:flutter_news/views/signup/index.dart';
import 'package:flutter_news/views/welcome/welcome.dart';

// 转场
Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  // you get an animation object and a widget
  // make your own transition
  return ScaleTransition(scale: animation, child: child);
}

// 路由观察者，扩展 AutoRouterObserver
class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {}
//  下面进行了举例扩展
//  @override
//  void didPush(Route route, Route? previousRoute) {
//    print('New route pushed: ${route.settings.name}');
//  }
//  @override
//  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
//    print('Tab route visited: ${route.name}');
//  }
//  @override
//  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
//    print('Tab route re-visited: ${route.name}');
//  }
}
// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
// 定义一个路由表的管理类，用来同意管理应用的路由，需要使用@MaterialAutoRouter注解进行标识
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: WelcomePage),
    AutoRoute(page: SignInPage),
    AutoRoute(page: SignUpPage, path: '/signup'),
    AutoRoute(page: ApplicationPage),
    CustomRoute(page: DetailsPage, transitionsBuilder: zoomInTransition),
    AutoRoute(page: MainPage),
    AutoRoute(page: AccountPage),
    AutoRoute(page: BookmarksPage),
    AutoRoute(page: CategoryPage),
  ],
)
class $AppRouter {}
