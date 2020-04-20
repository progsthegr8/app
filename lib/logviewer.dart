import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noolibee/color.dart';
import 'package:custom_switch/custom_switch.dart';

class LogViewer extends StatefulWidget {
  LogViewer({
    Key key,
  }) : super(key: key);

  @override
  _LogViewerState createState() => _LogViewerState();
}

class _LogViewerState extends State<LogViewer> {
  final dnsController = TextEditingController();
  List<Log> logs = List<Log>();

  @override
  void initState() {
    logs.add(new Log("12:49:58", "Start", "Application started"));
    logs.add(new Log("12:49:58", "Loaded", "Gateway User Controler Loaded"));
    logs.add(new Log("12:49:58", "Exception", "New problem"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Noolibee',
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: color1,
              title: Center(
                child: Text(
                  "Log Viewer",
                  style: TextStyle(color: color2),
                ),
              ),
            ),
            body: Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          itemCount: logs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20),
                              padding: EdgeInsets.all(10),
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 2.0, color: color1),
                                  left: BorderSide(width: 2.0, color: color1),
                                  right: BorderSide(width: 2.0, color: color1),
                                  bottom: BorderSide(width: 2.0, color: color1),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 100,
                                      color: color2,
                                      child: Center(
                                        child: Text(logs[index].time,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                      )),
                                  Expanded(
                                    child: ListView(
                                      children: <Widget>[
                                        Text(logs[index].titre,
                                            style: TextStyle(
                                                color: color1,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        Text(logs[index].description,
                                            style: TextStyle(
                                                color: color1,
                                                fontSize: 18))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: FlatButton(
                      color: color2,
                      textColor: color1,
                      padding: EdgeInsets.all(15),
                      //splashColor: Colors.white,
                      onPressed: () {},
                      child: Text(
                        "CLEAN",
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class Log {
  final String time;
  final String titre;
  final String description;

  Log(this.time, this.titre, this.description);
}
