import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/home/model/todo_model.dart';
import 'package:todo_app/utils/custom_popups.dart';
import 'package:todo_app/utils/navigation_key.dart';

class HomeController extends ChangeNotifier {
  final _todosCollection = FirebaseFirestore.instance.collection('todos');
  bool _loader = false;
  bool get loader => _loader;
  List<Todo> todoList = [];
  bool togleTranslation = false;

  String _todoKey = "todos";
  SharedPreferences? pref;
  HomeController() {
    _initPref();
  }
  _initPref() async {
    pref ??= await SharedPreferences.getInstance();
  }

  init() {
    todoList.clear();
    getTodos();
  }

  void getTodos() async {
    setLoader = true;
    try {
      final querySnapshot = await _todosCollection.get();

      final todos = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Todo.fromMap(data);
      }).toList();

      todoList.addAll(todos);
    } catch (e) {
      toast('${"7".tr()}: $e', isError: true);
    }
    if (todoList.isEmpty) {
      var data = await getDataFromPref();
      todoList = data.map((data) {
        return Todo.fromMap(data);
      }).toList();
    }
    setLoader = false;
  }

  Future<void> deleteTodo(String id, int index) async {
    setLoader = true;
    try {
      final todoDocument =
          FirebaseFirestore.instance.collection('todos').doc(id);

      // Delete the document
      await todoDocument.delete();
      todoList.removeAt(index);
      var data = await getDataFromPref();
      var idx = data.indexWhere((item) {
        return item["id"] == id;
      });
      if (index >= 0) {
        data.removeAt(idx);
        pref?.setString(_todoKey, jsonEncode(data));
      }
      toast('8'.tr());
    } catch (e) {
      toast('${"9".tr()}: $e', isError: true);
    }
    setLoader = false;
  }

  Future<void> toggleTodoCompletion(
      String id, bool isCompleted, int index) async {
    setLoader = true;
    try {
      final todoDocument =
          FirebaseFirestore.instance.collection('todos').doc(id);
      await todoDocument.update({'isCompleted': isCompleted});
      toast('10'.tr());
      todoList[index].isCompleted = isCompleted;
      var data = await getDataFromPref();
      var idx = data.indexWhere((item) {
        return item["id"] == id;
      });
      if (index >= 0) {
        data[idx]["isCompleted"] = isCompleted;
        pref?.setString(_todoKey, jsonEncode(data));
      }
    } catch (e) {
      toast('${"11".tr()}: $e', isError: true);
    }
    setLoader = false;
  }

  set setLoader(bool value) {
    _loader = value;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getDataFromPref() async {
    List<Map<String, dynamic>> tempList = [];

    if (pref?.containsKey(_todoKey) == true) {
      String? data = pref?.getString(_todoKey);
      if (data != null) {
        tempList.addAll(jsonDecode(data));
      }
    }
    return tempList;
  }

  set setTogleTranlation(bool value) {
    if (value == true) {
      NavigationService.navigatorKey.currentContext?.setLocale(Locale("ar"));
    } else {
      NavigationService.navigatorKey.currentContext?.setLocale(Locale("en"));
    }
    togleTranslation = value;
    notifyListeners();
  }
}
