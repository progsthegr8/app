import 'package:flutter/material.dart';
import 'package:noolibee/classes/log.dart';
import 'package:noolibee/classes/mymodel.dart';
import 'package:noolibee/main_dashboard.dart';
import 'package:noolibee/screens/config.dart';
import 'package:noolibee/screens/gateway.dart';
import 'package:noolibee/screens/logviewer.dart';
import 'package:noolibee/screens/mqtt.dart';
import 'package:noolibee/screens/network.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp(model: MyModel()));

class MyApp extends StatelessWidget {
  final MyModel model;

  const MyApp({Key key, @required this.model}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MyModel>(
      model: model,
      child: MaterialApp(
        title: 'Noolibee',
        home:MenuDashboardPage(),
      )
    );
  }
}

