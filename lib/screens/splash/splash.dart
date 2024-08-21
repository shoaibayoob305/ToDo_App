import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo_app/utils/extension/custom_extentions.dart';
import 'dart:async';

import 'package:todo_app/utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    // Navigate to the home screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(RoutesNames.home);
    });
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal, // Background color of the splash screen
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons
                        .check_circle_outline, // An icon that represents the todo app
                    size: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "3".tr(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Text(
                "Version ${_packageInfo.buildNumber}",
                style: TextStyle(color: Colors.white),
              ),
              50
              .sbh
            ],
          )
        ],
      ),
    );
  }
}
