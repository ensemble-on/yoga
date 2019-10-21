import 'package:flutter/material.dart';
import 'package:yoga/app/firstroute.dart';
import 'package:yoga/app/load_model.dart';
import 'package:yoga/app/secondroute.dart';
import 'package:yoga/app/thirdroute.dart';
import 'package:yoga/login/auth.dart';

import 'dart:async';
import 'package:camera/camera.dart';


List<CameraDescription> cameras;

Future<Null> main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
}

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});

  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }
    }
    return new Scaffold(
      appBar: new AppBar(
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white))
            ),
          ]
      ),
      body: ThirdRoute(cameras),
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.accessibility),
//          onPressed: () async {
//            try {
//              cameras = await availableCameras();
//            } on CameraException catch (e) {
//              print('Error: $e.code\nError Message: $e.message');
//            }
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => ThirdRoute(cameras)),
//            );
//          },
//        ),
    );
  }
}