import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/screens/home/home.dart';

Future<bool?> toast(String text,{bool isError=false}){
  return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:isError?Colors.red: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0
    );

}






Future<bool?> showDeleteConfirmationDialog(BuildContext context,void Function() onPressed) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevents closing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('25'.tr()),
        content: Text('26'.tr()),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('28'.tr()),
          ),
          TextButton(
            onPressed:onPressed,
            child: Text('27'.tr()),
          ),
        ],
      );
    },
  );
}


Future<bool?> showCompleteConfirmationDialog(BuildContext context,void Function() onPressed) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevents closing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('30'.tr()),
        content: Text('31'.tr()),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('28'.tr()),
          ),
          TextButton(
            onPressed:onPressed,
            child: Text('29'.tr()),
          ),
        ],
      );
    },
  );
}
