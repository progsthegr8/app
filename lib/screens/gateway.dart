import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noolibee/classes/mymodel.dart';
import 'package:noolibee/colors/color.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:noolibee/screens/logviewer.dart';
import 'package:noolibee/screens/network.dart';
import 'package:scoped_model/scoped_model.dart';

class Gateway extends StatefulWidget {
  Gateway({
    Key key,
  }) : super(key: key,);

  @override
  _GatewayState createState() => _GatewayState();
}

class _GatewayState extends State<Gateway> {
  final gatewayController = TextEditingController();
  final maskController = TextEditingController();
  final networkController = TextEditingController();
  final dnsController = TextEditingController();
  final timeController = TextEditingController();
  bool _enabled = true;

  @override
  void initState() {
    print("gate" + MyModel.of(context).data.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: color1,
          title: Center(
            child: Text(
              "Gateway IP",
              style: TextStyle(color: color2),
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String result) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LogViewer()),
                );
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  child: Text('Logs'),
                  value: "0",
                ),
              ],
            )
          ],
        ),
        body: Builder(builder: (BuildContext context) {
          return Container(
            padding:
            EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 100, right: 60, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 40,
                                child: Text("IP",
                                    style: TextStyle(
                                        color: color1, fontSize: 18)),
                              ),
                              CustomSwitch(
                                activeColor: color1,
                                value: _enabled,
                                onChanged: (value) {
                                  setState(() {
                                    _enabled = !_enabled;
                                  });
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
                  padding:
                  EdgeInsets.only(top: 18.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: color1))),
                  child: TextField(
                    enabled: !_enabled,
                    controller: gatewayController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Gateway IP",
                        hintStyle: TextStyle(color: color1)),
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: color1))),
                  child: TextField(
                    enabled: !_enabled,
                    controller: maskController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Mask",
                        hintStyle: TextStyle(color: color1)),
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: color1))),
                  child: TextField(
                    enabled: !_enabled,
                    controller: networkController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Network Gateway IP",
                        hintStyle: TextStyle(color: color1)),
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: color1))),
                  child: TextField(
                    enabled: !_enabled,
                    controller: dnsController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Network DNS",
                        hintStyle: TextStyle(color: color1)),
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: color1))),
                  child: TextField(
                    enabled: !_enabled,
                    controller: timeController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Time Server",
                        hintStyle: TextStyle(color: color1)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: FlatButton(
                      color: color2,
                      textColor: color1,
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Next",
                      ),
                      onPressed: () {
                        print(MyModel.of(context).data);
                        if (!_enabled) {
                          if (gatewayController.text.isEmpty) {
                            _showDialog("There's no gateway IP", context);
                          } else if (maskController.text.isEmpty) {
                            _showDialog("There's no mask", context);
                          } else if (networkController.text.isEmpty) {
                            _showDialog("There's no network IP", context);
                          } else if (dnsController.text.isEmpty) {
                            _showDialog("There's no dns", context);
                          } else if (timeController.text.isEmpty) {
                            _showDialog("There's no time server", context);
                          } else {
                            MyModel.of(context).data['id'] = {
                              "dhcp": 0,
                              "dns": [dnsController.text],
                              "gateway": gatewayController.text,
                              "ip": networkController.text,
                              "mask": maskController.text,
                              "ntpd": timeController.text
                            };
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Network()),
                            );
                          }
                        } else {
                          MyModel.of(context).data['id'] = {
                            "dhcp": 1,
                            "dns": ["8.8.8.8", "4.4.4.4"],
                            "gateway": "192.168.1.1",
                            "ip": "192.168.1.80",
                            "mask": "255.255.255.0",
                            "ntpd": "time.google.com"
                          };
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Network()),
                          );
                        }
                      }),
                ),
              ],
            ),
          );
        }));
  }
}
