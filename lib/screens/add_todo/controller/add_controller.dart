import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/add_todo/model/create_model.dart';
import 'package:todo_app/screens/home/model/todo_model.dart';
import 'package:todo_app/utils/custom_popups.dart';
import 'package:todo_app/utils/navigation_key.dart';

class AddController extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  BuildContext get context =>
      NavigationService.navigatorKey.currentState!.context;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  bool _loader = false;
  bool get loader => _loader;
  set setDueDate(DateTime time) {
    _selectedDate = time;
    notifyListeners();
  }

  set setLoader(bool value) {
    _loader = value;
    notifyListeners();
  }

  String _todoKey = "todos";
  SharedPreferences? pref;

AddController(){
  _initPref();
}
 _initPref() async {
    pref ??= await SharedPreferences.getInstance();
  }

  setParam(Todo data) {
    titleController.text = data.title.toString();
    descriptionController.text = data.description.toString();
    setDueDate = data.dueDate!;
  }

  Future<void> createTodo() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate == null) {
      toast("Enter required data", isError: true);
      return;
    }
    setLoader = true;

// for local pref
    List<Map> prefdata = [];
    if (pref?.containsKey(_todoKey) == true) {
      String? data = pref?.getString(_todoKey);
      if (data != null) {
        prefdata.addAll(jsonDecode(data));
      }
    }
    String id = FirebaseFirestore.instance.collection(_todoKey).doc().id;

    CreateTodoModel newTodo = CreateTodoModel(
      id: id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      dueDate: _selectedDate,
      isCompleted: false,
    );

    try {
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(id)
          .set(newTodo.toMap());
      toast("24".tr());
      Navigator.pop(context);
      prefdata.add(newTodo.toMap());
      pref?.setString(_todoKey, jsonEncode(prefdata));
      resetFields();
    } catch (e) {
      toast("${"21".tr()}: $e", isError: true);
    }
    setLoader = false;
  }

  Future<void> updateTodo({required Todo todo}) async {
    setLoader = true;
    try {

      List<Map> prefdata = [];
      if (pref?.containsKey(_todoKey) == true) {
        String? data = pref?.getString(_todoKey);
        if (data != null) {
          prefdata.addAll(jsonDecode(data));
        }
      }
      final todoDocument =
          FirebaseFirestore.instance.collection('todos').doc(todo.id);

      CreateTodoModel newTodo = CreateTodoModel(
        id: todo.id!,
        title: titleController.text.isEmpty
            ? todo.title!
            : titleController.text.trim(),
        description: descriptionController.text.isEmpty
            ? todo.description!
            : descriptionController.text.trim(),
        dueDate: _selectedDate == null ? todo.dueDate : _selectedDate,
        isCompleted: todo.isCompleted,
      );

      int index = prefdata.indexWhere((item) {
        return item["id"] == todo.id!;
      });
      if (index >= 0) {
        prefdata.removeAt(index);
        prefdata.insert(index, newTodo.toMap());
        pref?.setString(_todoKey, jsonEncode(prefdata));
      }
      // Update the document
      await todoDocument.update(newTodo.toMap());
      toast('22'.tr());
      Navigator.pop(context);
    } catch (e) {
      toast('${"23".tr()}: $e', isError: true);
    }
  }

  Map _getupdatePrefData(List<Map> prefdata, String id) {
    Map tempMap = {};
    for (int i = 0; i < prefdata.length; i++) {
      if (prefdata[i]["id"] == id) {
        tempMap = prefdata[i];
        break;
      }
    }
    return tempMap;
  }

  resetFields() {
    titleController.clear();
    descriptionController.clear();
    _selectedDate = null;
  }
}
