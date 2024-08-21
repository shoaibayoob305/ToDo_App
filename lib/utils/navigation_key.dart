import 'package:flutter/material.dart';

class NavigationService {
 static  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();





  Future<void> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments) ?? Future.value();
  }


  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
