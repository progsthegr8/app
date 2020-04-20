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
class Network extends StatefulWidget {
  Network({Key key,}) : super(key: key);

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  final apnController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final ssidController = TextEditingController();
  final passWifiController = TextEditingController();
  final CounterStorage storage = CounterStorage();
  List listWifi = List();

  bool status = true;
  bool status2 = false;
  bool status3 = false;
  int display = 1;

  @override
  void initState() {
    if(listWifi.contains('wifi')){
    listWifi.addAll(MyModel.of(context).data['wifi']['list']);
    }else{
      new Container();
    }
    super.initState();
  }

  Future<File> _writeData() {
    // Write the variable as a string to the file.
    return storage.writeData(MyModel.of(context).data);
  }

  Future<void> sendFileToServer() async {
    var client = new SSHClient(
      host: "81.66.104.74",
      port: 22,
      username: "root",
      passwordOrKey: "Monarch102009!",
    );

    String result;
    try {
      result = await client.connect();
      if (result == "session_connected") {
        result = await client.connectSFTP();
        if (result == "sftp_connected") {
          final directory = await getApplicationDocumentsDirectory();
          await client.sftpUpload(
            path: directory.path + "/newbr.conf",
            toPath: ".",
            callback: (progress) {
              print(progress); // read upload progress
            },
          );
           Fluttertoast.showToast(
        msg: "file sent to the server",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor:color2,
        textColor: Colors.white,
        fontSize: 16.0
    );
          MyModel.of(context)
              .logs
              .add(Log("File sent", "Successfully sent conf file to server !"));
        }
      }
      client.disconnect();
    } on PlatformException catch (e) {
      MyModel.of(context)
          .logs
          .add(Log("Error", "${e.code}\nError Message: ${e.message}"));
    }
  }

  void _showDialog(msg, context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("CHAMPS INCOMPLETS !"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkDisplay() {
    if (display == 1) {
      MyModel.of(context).data['ethernet'] = {"eth": "1"};
      _writeData();
      sendFileToServer();
    }
    if (display == 2) {
      MyModel.of(context).data['ethernet'] = {"eth": "0"};
      _writeData();
      sendFileToServer();
    }
    if (display == 3) {
      if (apnController.text.isEmpty) {
        _showDialog("There's no apn", context);
      } else if (nameController.text.isEmpty) {
        _showDialog("There's no username", context);
      } else if (passController.text.isEmpty) {
        _showDialog("There's no password", context);
      } else {
        MyModel.of(context).data['ethernet'] = {"eth": "0"};
        MyModel.of(context).data['gprs'] = {
          "apn": apnController.text,
          "username": nameController.text,
          "password": passController.text
        };
        _writeData();
        sendFileToServer();
      }
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
              "Network",
              style: TextStyle(color: color2),
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String result) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogViewer()),
                );
              },
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  child: Text('Logs'),
                  value: "0",
                ),
              ],
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 30.0, left: 30, right: 30),
          child: ListView(
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
                            Checkbox(
                              activeColor: color1,
                              value: status,
                              onChanged: (value) {
                                setState(() {
                                  status = true;
                                  status2 = false;
                                  status3 = false;
                                  display = 1;
                                });
                              },
                            ),
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
                            Checkbox(
                              activeColor: color1,
                              value: status2,
                              onChanged: (value) {
                                setState(() {
                                  status = false;
                                  status2 = true;
                                  status3 = false;
                                  display = 2;
                                });
                              },
                            ),
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
                            Checkbox(
                              activeColor: color1,
                              value: status3,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    status = false;
                                    status2 = false;
                                    status3 = true;
                                    display = 3;
                                  }
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
              Container(
                color: color2,
                margin: EdgeInsets.only(top: 20),
                child: FlatButton(
                  color: color2,
                  textColor: color1,
                  padding: EdgeInsets.all(15),
                  //splashColor: Colors.white,
                  onPressed: checkDisplay,
                  child: Text(
                    "Send",
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget displayWiFi() {
    List<Widget> listWidget = List();
    if (listWifi.length == 0) return Container();
    for (int i = 0; i < listWifi.length; i++) {
      listWidget.add(Container(
          height: 40,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                  flex: 5,
                  child: SizedBox.expand(
                      child: Text(listWifi[i]['Ssid'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)))),
              Flexible(
                  flex: 7,
                  child: SizedBox.expand(
                      child: Text(listWifi[i]['Password'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)))),
              Flexible(
                  flex: 2,
                  child: SizedBox.expand(
                    child: FlatButton(
                      //splashColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          MyModel.of(context).data['wifi']['list'].removeAt(i);
                          listWifi.removeAt(i);
                        });
                      },
                      child: Icon(Icons.delete, size: 20, color: color3),
                    ),
                  )),
            ],
          )));
    }
    Widget retour = Column(
      children: listWidget,
    );
    return Container(
      height: listWifi.length * 40.0,
      child: retour,
    );
  }

  Widget displayWidget() {
    if (display == 3) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: color1))),
            child: TextField(
              controller: apnController..text = MyModel.of(context).data['gprs']['apn'],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Apn",
                  labelStyle: TextStyle(color: color1)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: color1))),
            child: TextField(
              controller: nameController
                ..text = MyModel.of(context).data['gprs']['username'],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Username",
                  labelStyle: TextStyle(color: color1)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: color1))),
            child: TextField(
              controller: passController
                ..text = MyModel.of(context).data['gprs']['password'],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Password",
                  labelStyle: TextStyle(color: color1)),
            ),
          ),
        ],
      );
    } else if (display == 2) {
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
              height: 30,
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 5,
                      child: SizedBox.expand(
                          child: Text(
                              "SSID" /*widget.data['wifi']['list'][0]['Password']*/,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)))),
                  Flexible(
                      flex: 7,
                      child: SizedBox.expand(
                          child: Text(
                              "Password" /*widget.data['wifi']['list'][0]['Ssid']*/,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)))),
                  Flexible(
                      flex: 2,
                      child: SizedBox.expand(
                          child: Text("Delete",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)))),
                ],
              )),
          displayWiFi(),
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
              height: 220,
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
                    color: color2,
                    margin: EdgeInsets.only(top: 20),
                    child: FlatButton(
                      color: color2,
                      textColor: color1,
                      padding: EdgeInsets.all(15),
                      //splashColor: Colors.white,
                      onPressed: () {
                        if (ssidController.text.isEmpty) {
                          _showDialog("There's no Ssid !", context);
                        } else {
                          setState(() {
                            listWifi.add({"Password": passWifiController.text, "Ssid": ssidController.text});
                            MyModel.of(context).data['wifi']['list'].add({"Password": passWifiController.text, "Ssid": ssidController.text});
                          });
                          passWifiController.text = "";
                          ssidController.text = "";
                        }
                      },
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
