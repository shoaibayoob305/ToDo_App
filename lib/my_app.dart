import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/add_todo/controller/add_controller.dart';
import 'package:todo_app/screens/home/controller/home_controller.dart';
import 'package:todo_app/utils/navigation_key.dart';
import 'package:todo_app/utils/routes/generated_routes.dart';
import 'package:todo_app/utils/routes/routes_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context)=> HomeController(),),

        ChangeNotifierProvider(create:(context)=> AddController(),),
      ],
      child: MaterialApp(
        title: 'ToDo App',
        navigatorKey: NavigationService.navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute:RouterClass.generateRoute,
        initialRoute: RoutesNames.splash,
        theme: ThemeData(
          useMaterial3: true,
        ),
      ),
    );
  }
}
