import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noolibee/color.dart';
import 'package:custom_switch/custom_switch.dart';

class MQTT extends StatefulWidget {
  MQTT({
    Key key,
  }) : super(key: key);

  @override
  _MQTTState createState() => _MQTTState();
}

class _MQTTState extends State<MQTT> {
  final dnsController = TextEditingController();

  @override
  void initState() {
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
                  "MQTT BROKER",
                  style: TextStyle(color: color2),
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: color1))),
                    child: TextField(
                      controller: dnsController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Network DNS",
                          hintStyle: TextStyle(color: color1)),
                    ),
                  ),
                ],
              ),
            )));
  }
}
