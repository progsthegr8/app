import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noolibee/color.dart';
import 'package:custom_switch/custom_switch.dart';

class Config extends StatefulWidget {
  Config({
    Key key,
  }) : super(key: key);

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final dnsController = TextEditingController();

  List _cities = ["192.168.1.3", "192.168.4.4", "192.168.5.5"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
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
                  "Server Configuration",
                  style: TextStyle(color: color2),
                ),
              ),
            ),
            body: Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _currentCity,
                      iconSize: 24,
                      iconEnabledColor: color1,
                      elevation: 16,
                      style: TextStyle(color: color1, fontSize: 24),
                      underline: Container(
                        height: 2,
                        color: color1,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _currentCity = newValue;
                        });
                      },
                      items: _dropDownMenuItems,
                    ),
                  ),
                  Expanded(child: Center()),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: FlatButton(
                      color: color2,
                      textColor: color1,
                      padding: EdgeInsets.all(15),
                      //splashColor: Colors.white,
                      onPressed: () {},
                      child: Text(
                        "START",
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
