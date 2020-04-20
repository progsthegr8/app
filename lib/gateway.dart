import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noolibee/color.dart';
import 'package:custom_switch/custom_switch.dart';

class Gateway extends StatefulWidget {
  Gateway({
    Key key,
  }) : super(key: key);

  @override
  _GatewayState createState() => _GatewayState();
}

class _GatewayState extends State<Gateway> {
  final gatewayController = TextEditingController();
  final maskController = TextEditingController();
  final networkController = TextEditingController();
  final dnsController = TextEditingController();
  final timeController = TextEditingController();

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
                  "Gateway IP",
                  style: TextStyle(color: color2),
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 60, right: 60, bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  child: Text("Ethernet",
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                ),
                                CustomSwitch(
                                  activeColor: color1,
                                  value: false,
                                  onChanged: (value) {
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  width: 80,
                                  child: Text("DHCP",
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18.0, left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: color1))),
                    child: TextField(
                      controller: gatewayController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Gateway IP",
                          hintStyle: TextStyle(color: color1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: color1))),
                    child: TextField(
                      controller: maskController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Mask",
                          hintStyle: TextStyle(color: color1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: color1))),
                    child: TextField(
                      controller: networkController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Network Gateway IP",
                          hintStyle: TextStyle(color: color1)),
                    ),
                  ),
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
                  Container(
                    padding: EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: color1))),
                    child: TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Time Server",
                          hintStyle: TextStyle(color: color1)),
                    ),
                  ),
                ],
              ),
            )));
  }
}
