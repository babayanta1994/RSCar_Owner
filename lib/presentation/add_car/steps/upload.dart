import 'dart:collection';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  var mapInfo = HashMap<String, String>();

  Upload(this.mapInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UploadState();
  }
}

class UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    var category = widget.mapInfo["category"].toString();
    var brand = widget.mapInfo["brand"].toString();
    var model = widget.mapInfo["model"].toString();
    var year = widget.mapInfo["year"].toString();
    var color = widget.mapInfo["color"].toString();
    var country = widget.mapInfo["country"].toString();
    var city = widget.mapInfo["city"].toString();
    var email = widget.mapInfo["email"].toString();
    var address = widget.mapInfo["address"].toString();
    var mobile_no = widget.mapInfo["mobile_no"].toString();

    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "category: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(category, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text(
                "brand: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(brand, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          
          Row(
            children: <Widget>[
              Text(
                "model: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(model, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),


          Row(
            children: <Widget>[
              Text(
                "year: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(year, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),


          Row(
            children: <Widget>[
              Text(
                "color: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(color, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),


          Row(
            children: <Widget>[
              Text(
                "country: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(country, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),


          Row(
            children: <Widget>[
              Text(
                "city: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(city, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),


          
          
        ],
      ),
    );
  }
}
