import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_todo/add_todo.dart';
import 'package:todo_app/screens/home/home.dart';
import 'package:todo_app/screens/not_found.dart';
import 'package:todo_app/screens/splash/splash.dart';

import 'package:todo_app/utils/routes/routes_name.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesNames.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesNames.addTodo:
        var args = settings.arguments??{} ;
        return MaterialPageRoute(
            builder: (context) => AddTodoScreen(
                  routeData: args as Map<dynamic,dynamic>,
                ));
      default:
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
}
