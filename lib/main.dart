import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
await Firebase.initializeApp();

  runApp(

    EasyLocalization(
    path: 'assets/translations',
    supportedLocales: const [
      Locale('en'),
      Locale('ar'),
    ],
    fallbackLocale: Locale('en'),

    child: const MyApp(),
  )
    );
}

