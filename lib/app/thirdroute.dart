import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:yoga/app/model_page.dart';
import 'package:yoga/login/home_page.dart';

import 'models.dart';

class ThirdRoute extends StatefulWidget {
  TextEditingController _textFieldController = TextEditingController();
  final List<CameraDescription> cameras;

  ThirdRoute(this.cameras);

  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = new FlutterTts();
    flutterTts.speak("Welcome Back Siraj. Are you ready for your session?");
    return Scaffold(
        backgroundColor: Color(0xff7F84BE),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Current level: 0/10",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        fontFamily: "Arial"),
                  ),
                  Image.asset(
                    'assets/lola.gif',
                  ),
                  Text(
                    "Welcome back, Siraj.",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        fontFamily: "Arial"),
                  ),
                  ButtonTheme(
                      minWidth: 180.0,
                      height: 50.0,
                      child: RaisedButton(
                          child: const Text("Begin"),
                          color: Colors.deepPurpleAccent,

                          onPressed: () async {
                            try {
                              cameras = await availableCameras();
                            } on CameraException catch (e) {
                              print('Error: $e.code\nError Message: $e.message');
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ModelPage(cameras)),
                            );
                          },
                      )),
                  SizedBox(height: 10),
                ])));
  }
}