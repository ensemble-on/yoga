import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:yoga/app/secondroute.dart';
import 'package:yoga/app/thirdroute.dart';
import 'package:yoga/login/home_page.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}

class FirstRoute extends StatefulWidget {
  final List<CameraDescription> cameras;

  FirstRoute(this.cameras);

  @override
  _FirstRouteState createState() => new _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yoganet.tflite",
        );
        break;

      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      case yoganet:
        res = await Tflite.loadModel(model: "assets/model.tflite");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: Color(0xff7F84BE),
      body: _model == ""
          ? Center(
        child: ListView(
          children: <Widget>[
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Image.asset(
        'assets/lola.gif',
        ),
        Text(
          "Macy",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
              fontFamily: "Arial"),
        ),
        new Container(
          width: 300.0,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
          ),
        ),
        new Container(
          width: 300.0,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
        ),
        SizedBox(height: 10),
        ButtonTheme(
          minWidth: 180.0,
          height: 50.0,
          child: RaisedButton(
              child: const Text("Login"),
              color: Colors.deepPurpleAccent,
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ThirdRoute(cameras)),
                  )),
        ),
        SizedBox(height: 10),
        ButtonTheme(
          minWidth: 180.0,
          height: 50.0,
          child: RaisedButton(
              child: const Text("Sign up"),
              color: Colors.deepPurpleAccent,
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondRoute()),
                  )),
        ),
      ],
    ),
    ],
    ))
      : Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          BndBox(
            _recognitions == null ? [] : _recognitions,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
            _model
          ),
        ],
      ),
    );
  }
}
