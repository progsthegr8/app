import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noolibee/classes/log.dart';
import 'package:noolibee/classes/mymodel.dart';
import 'package:noolibee/colors/color.dart';
import 'package:noolibee/datastorage.dart';
import 'package:noolibee/screens/logviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssh/ssh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Config extends StatefulWidget {
  Config({
    Key key,
  }) : super(key: key);

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final dnsController = TextEditingController();

  /*List _cities = ["192.168.1.3", "192.168.4.4", "192.168.5.5"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }*/

  /*List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }*/
Future<void> connectToServer() async {
    var client = new SSHClient(
      host: "81.66.104.74",
      port: 22,
      username: "root",
      passwordOrKey: "Monarch102009!"
    );
    String result;
    try {
      result = await client.connect();
      if (result == "session_connected"){
       MyModel.of(context)
              .logs
              .add(Log("connection done", "Successfully connected !"));
              } client.disconnect();
    } on PlatformException catch (e) {
      MyModel.of(context)
          .logs
          .add(Log("Error", "${e.code}\nError Message: ${e.message}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: color1,
          title: Center(
            child: Text(
              "Server Configuration",
              style: TextStyle(color: color2),
            ),
          ),
          actions: <Widget>[
           PopupMenuButton<String>(
             onSelected:(String result){
               Navigator.push(context,
                 MaterialPageRoute(builder: (context) => LogViewer()),
               );
               },
               itemBuilder:(BuildContext context)=>
               <PopupMenuEntry<String>>[
                 const PopupMenuItem<String>(
                   child: Text('logs'),
                   value:"0",
                 )
               ]
             ) 
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10, bottom: 30, left: 10, right: 10),
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
                      hintText: "Enter IP",
                      hintStyle: TextStyle(color: color1)),
                )
              ),
        Expanded(child: Center()),
              Container(
                margin: EdgeInsets.only(top: 20,bottom:350),
                child: FlatButton(
                  color: color2,
                  textColor: color1,
                  padding: EdgeInsets.all(15),
                  //splashColor: Colors.white,
                  onPressed: () {
                    connectToServer();
                    Fluttertoast.showToast(
                    msg: "Connected to the server",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: color1,
                    textColor: Colors.white,
                    fontSize: 16.0
                    );
                  },
                  child: Text(
                    "START",
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
