import 'dart:collection';
import 'package:flutter/material.dart';

class RegisterUpload extends StatefulWidget {
  var mapInfo = HashMap<String, String>();

  RegisterUpload(this.mapInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterUploadState();
  }
}

class RegisterUploadState extends State<RegisterUpload> {
  @override
  Widget build(BuildContext context) {
    var category = widget.mapInfo["category"].toString();

    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
