import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news/router/index.dart';
import 'package:flutter_news/router/index.gr.dart';
import 'package:flutter_news/store/index.dart';
import 'package:flutter_news/global.dart';
import 'package:provider/provider.dart';

// 主程处理调用
void main() => Global.init().then((e) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppState>.value(
            value: Global.appState,
          ),
        ],
        child: Consumer<AppState>(builder: (context, appState, _) {
          if (appState.isGrayFilter) {
            return const ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
              child: MyApp(),
            );
          } else {
            return const MyApp();
          }
        }),
      ),
));

// 路由匹配处理
class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    // 路由表跳转方式需要配置
    // 这里是原框架的静态路由方式staticRouters对应的是lib/__routes.dart
    // return MaterialApp(
    //   title: 'Flutter News',
    //   home: const HomePage(),
    //   routes: staticRoutes,
    //   debugShowCheckedModeBanner: false,
    // );

    // 下面为autoRouter的配置方式
    return MaterialApp.router(

//      theme: ThemeData(
//      ),
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [AppRouteObserver()],
      ),
      routeInformationProvider: _appRouter.routeInfoProvider(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
