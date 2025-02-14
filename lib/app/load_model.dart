import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'models.dart';

class LoadModel extends StatelessWidget {

  TextEditingController _textFieldController = TextEditingController();

  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  Widget build(BuildContext context) {
    return   onSelect(posenet);
  }

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
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
    _model = model;

    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    _recognitions = recognitions;
    _imageHeight = imageHeight;
    _imageWidth = imageWidth;
  }
}