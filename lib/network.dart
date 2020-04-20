import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noolibee/color.dart';
import 'package:custom_switch/custom_switch.dart';

class Network extends StatefulWidget {
  Network({
    Key key,
  }) : super(key: key);

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  final apnController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final ssidController = TextEditingController();
  final passWifiController = TextEditingController();

  bool status = true;
  bool status2 = false;
  bool status3 = false;
  int display = 3;

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
                  "Network",
                  style: TextStyle(color: color2),
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.all(30.0),
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
                                  width: 100,
                                  child: Text("Ethernet",
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                ),
                                CustomSwitch(
                                  activeColor: color1,
                                  value: false,
                                  onChanged: (value) {
                                    setState(() {
                                      display = 1;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 60, right: 60, bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  child: Text("Wifi",
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                ),
                                CustomSwitch(
                                  activeColor: color1,
                                  value: false,
                                  onChanged: (value) {
                                    setState(() {
                                      display = 2;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 60, right: 60, bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  child: Text("Gprs",
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                ),
                                CustomSwitch(
                                  activeColor: color1,
                                  value: true,
                                  onChanged: (value) {
                                    setState(() {
                                      display = 3;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  displayWidget(),
                ],
              ),
            )));
  }

  Widget displayWidget() {
    if (display == 3) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: color1))),
            child: TextField(
              controller: apnController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Apn",
                  hintStyle: TextStyle(color: color1)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: color1))),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Username",
                  hintStyle: TextStyle(color: color1)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: color1))),
            child: TextField(
              controller: passController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(color: color1)),
            ),
          ),
        ],
      );
    } else if (display == 2){
      return Column(
        children: <Widget>[
          Container(
              height: 50,
              padding: EdgeInsets.all(8.0),
              color: color1,
              child: SizedBox.expand(
                child: Text(
                  "Current Wifi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              )),
          Container(
              height: 100,
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 2,
                      child: SizedBox.expand(
                          child:Text("SSID",
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)))
                  ),
                  Flexible(
                      flex: 2,
                      child: SizedBox.expand(
                          child:Text("Password",
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)))
                  ),
                  Flexible(
                      flex: 1,
                      child: SizedBox.expand(
                          child:Text("Delete",
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)))
                  ),
                ],
              )),
          Container(
              height: 50,
              padding: EdgeInsets.all(8.0),
              color: color1,
              child: SizedBox.expand(
                child: Text(
                  "New",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              )),
          Container(
              height: 300,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: color1))),
                    child: TextField(
                      controller: ssidController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "SSID",
                          hintStyle: TextStyle(color: color1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: color1))),
                    child: TextField(
                      controller: passWifiController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(color: color1)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: FlatButton(
                      color: color2,
                      textColor: color1,
                      padding: EdgeInsets.all(15),
                      //splashColor: Colors.white,
                      onPressed: () {},
                      child: Text(
                        "ADD",
                      ),
                    ),
                  ),
                ],
              )),
        ],
      );
    } else {
      return Center();
    }
  }
}
