// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../common/entities/index.dart' as _i14;
import '../views/account/index.dart' as _i8;
import '../views/application/index.dart' as _i5;
import '../views/bookmarks/index.dart' as _i9;
import '../views/category/index.dart' as _i10;
import '../views/details/index.dart' as _i6;
import '../views/home/index.dart' as _i1;
import '../views/main/index.dart' as _i7;
import '../views/signin/index.dart' as _i3;
import '../views/signup/index.dart' as _i4;
import '../views/welcome/welcome.dart' as _i2;
import 'index.dart' as _i13;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.WelcomePage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignInPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SignUpPage(),
      );
    },
    ApplicationRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ApplicationPage(),
      );
    },
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.DetailsPage(
          key: args.key,
          item: args.item,
        ),
        transitionsBuilder: _i13.zoomInTransition,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.MainPage(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.AccountPage(),
      );
    },
    BookmarksRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.BookmarksPage(),
      );
    },
    CategoryRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.CategoryPage(),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i11.RouteConfig(
          WelcomeRoute.name,
          path: '/welcome-page',
        ),
        _i11.RouteConfig(
          SignInRoute.name,
          path: '/sign-in-page',
        ),
        _i11.RouteConfig(
          SignUpRoute.name,
          path: '/signup',
        ),
        _i11.RouteConfig(
          ApplicationRoute.name,
          path: '/application-page',
        ),
        _i11.RouteConfig(
          DetailsRoute.name,
          path: '/details-page',
        ),
        _i11.RouteConfig(
          MainRoute.name,
          path: '/main-page',
        ),
        _i11.RouteConfig(
          AccountRoute.name,
          path: '/account-page',
        ),
        _i11.RouteConfig(
          BookmarksRoute.name,
          path: '/bookmarks-page',
        ),
        _i11.RouteConfig(
          CategoryRoute.name,
          path: '/category-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.WelcomePage]
class WelcomeRoute extends _i11.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/welcome-page',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i3.SignInPage]
class SignInRoute extends _i11.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in-page',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i4.SignUpPage]
class SignUpRoute extends _i11.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/signup',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i5.ApplicationPage]
class ApplicationRoute extends _i11.PageRouteInfo<void> {
  const ApplicationRoute()
      : super(
          ApplicationRoute.name,
          path: '/application-page',
        );

  static const String name = 'ApplicationRoute';
}

/// generated route for
/// [_i6.DetailsPage]
class DetailsRoute extends _i11.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    _i12.Key? key,
    required _i14.NewsItem item,
  }) : super(
          DetailsRoute.name,
          path: '/details-page',
          args: DetailsRouteArgs(
            key: key,
            item: item,
          ),
        );

  static const String name = 'DetailsRoute';
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    this.key,
    required this.item,
  });

  final _i12.Key? key;

  final _i14.NewsItem item;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [_i7.MainPage]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute()
      : super(
          MainRoute.name,
          path: '/main-page',
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i8.AccountPage]
class AccountRoute extends _i11.PageRouteInfo<void> {
  const AccountRoute()
      : super(
          AccountRoute.name,
          path: '/account-page',
        );

  static const String name = 'AccountRoute';
}

/// generated route for
/// [_i9.BookmarksPage]
class BookmarksRoute extends _i11.PageRouteInfo<void> {
  const BookmarksRoute()
      : super(
          BookmarksRoute.name,
          path: '/bookmarks-page',
        );

  static const String name = 'BookmarksRoute';
}

/// generated route for
/// [_i10.CategoryPage]
class CategoryRoute extends _i11.PageRouteInfo<void> {
  const CategoryRoute()
      : super(
          CategoryRoute.name,
          path: '/category-page',
        );

  static const String name = 'CategoryRoute';
}
