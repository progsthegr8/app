import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noolibee/classes/log.dart';
import 'package:noolibee/classes/mymodel.dart';
import 'package:noolibee/colors/color.dart';
import 'package:noolibee/datastorage.dart';
import 'package:noolibee/screens/config.dart';
import 'package:noolibee/screens/logviewer.dart';
import 'package:noolibee/screens/mqtt.dart';
import 'package:noolibee/screens/network.dart';
import 'package:noolibee/screens/gateway.dart';
import 'package:ssh/ssh.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wifi_configuration/wifi_configuration.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  final CounterStorage storage = CounterStorage();

  Future<void> connectWIFI() async {
    try{
      bool isConnected = await WifiConfiguration.isConnectedToWifi("ssidName");
      if(!isConnected)
      WifiConnectionStatus connectionStatus = await WifiConfiguration.connectToWifi("Monarch", "", "com.noolitic.noolibee");
      getFileFromServer();
    } on PlatformException catch (e) {
    MyModel.of(context)
        .logs
        .add(Log("Error", "${e.code}\nError Message: ${e.message}"));
    }
  }

  Future<void> getFileFromServer() async {
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
        MyModel.of(context)
            .logs
            .add(Log("Connected", "Connexion to server successful !"));
        result = await client.connectSFTP();
        if (result == "sftp_connected") {
          Fluttertoast.showToast(
        msg: "connected to sftp ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:color2,
        textColor: Colors.white,
        fontSize: 16.0
    );
          MyModel.of(context)
              .logs
              .add(Log("Connected", "Connexion to sftp successful !"));

          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;
          var filePath = await client.sftpDownload(
            path: "br.conf",
            toPath: tempPath,
            callback: (progress) async {
              if (progress == 100)
                MyModel.of(context)
                    .logs
                    .add(Log("File downloaded", "Successfully downloaded conf file from server !"));
            },
          );
          var donnee = await storage.readData(filePath);
          MyModel.of(context).setData(donnee);
        }
      }
      client.disconnect();
    } on PlatformException catch (e) {
      MyModel.of(context)
          .logs
          .add(Log("Error", "${e.code}\nError Message: ${e.message}"));
    }
  }

  @override
  void initState() {
    MyModel.of(context).logs.add(Log("Start", "Application started"));
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    connectWIFI();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: color1,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  color: color2,
                  textColor: color1,
                  padding: EdgeInsets.all(15),
                  //splashColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogViewer()),
                    );
                  },
                  child: Text(
                    "Logs",
                  ),
                ),
                Padding(padding: EdgeInsets.all(20)),
                FlatButton(
                  color: color2,
                  textColor: color1,
                  padding: EdgeInsets.all(15),
                  //splashColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Config()),
                    );
                  },
                  child: Text(
                    "Server Configuration",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Colors.white10,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, size: 40, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      //Text("Choos", style: TextStyle(fontSize: 24, color: Colors.white)),
                      //Icon(Icons.settings, size: 40, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 200,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Gateway();
                              }));
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: color3,
                                width: 100,
                                child: Center(
                                    child: Text.rich(TextSpan(
                                        children: <TextSpan>[
                                      TextSpan(
                                          text: 'Gateway',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white))
                                    ]))))),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Network();
                            }));
                          },
                          child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              color: color2,
                              width: 100,
                              child: Center(
                                  child: Text.rich(TextSpan(
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: 'Network',
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.white))
                                  ])))),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MQTT();
                              }));
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: color1,
                                width: 100,
                                child: Center(
                                    child: Text.rich(TextSpan(
                                        children: <TextSpan>[
                                      TextSpan(
                                          text: 'MQTT',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white))
                                    ]))))),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
