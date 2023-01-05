import 'package:auto_route/auto_route.dart';
import 'package:flutter_news/utils/index.dart';
import 'index.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    var authenitcated = await isAuthenticated();
    if (authenitcated) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(const SignInRoute());
    }
  }
}
