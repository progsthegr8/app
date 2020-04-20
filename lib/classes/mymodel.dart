import 'dart:convert';

import 'package:noolibee/classes/log.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MyModel extends Model {
  Map data = new Map();
  List<Log> logs = List<Log>();

  static MyModel of(BuildContext context) =>
      ScopedModel.of<MyModel>(context);

  void addLog(log) {
    logs.add(log);
    notifyListeners();
  }

  void cleanLog() {
    logs = List<Log>();
    notifyListeners();
  }

  void setData(donnee) {
    data =  jsonDecode(donnee);
    notifyListeners();
  }
}