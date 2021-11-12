import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rs_car_owner/presentation/notifications/notifications.dart';

class GoogleView extends StatefulWidget {
  const GoogleView({Key? key}) : super(key: key);

  @override
  _GoogleMapInit createState() => _GoogleMapInit();
}

class _GoogleMapInit extends State<GoogleView> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  Completer<GoogleMapController> _controller = Completer();
  Location _location = Location();
  Set<Marker> _markers = Set();
  bool isUpdatePosition = true;
  bool isUpdatePositionCars = true;

  @override
  void initState() {
    _getLoc();
    super.initState();
  }

  void _getLoc() {
    _location.getLocation().asStream().listen((l) {
      _initialcameraposition =
          LatLng(l.latitude ?? 20.5937, l.longitude ?? 78.9629);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      _currentLocation();
    });
    setState(() {
      _updateCars();
    });
  }

  void _updateCars() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _location.getLocation().asStream().listen((l) {
        _handleGetMarkers(
            LatLng(l.latitude ?? 20.5937, l.longitude ?? 78.9629));
      });
    });
  }

  void _updateLocation() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _location.getLocation().asStream().listen((l) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(l.latitude ?? 20.5937, l.longitude ?? 78.9629),
                zoom: 15),
          ),
        );
      });
    });
    print("<<<<_updateLocation>>>>");
  }

  void _getcurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData? currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    try {
      _updateCars();
    } finally {}

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation!.latitude ?? 20.5937,
            currentLocation!.longitude ?? 78.9629),
        zoom: 17.0,
      ),
    ));
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    _location.onLocationChanged.listen((l) {
      if (isUpdatePosition) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(l.latitude ?? 20.5937, l.longitude ?? 78.9629),
                zoom: 15),
          ),
        );
        isUpdatePosition = false;
      }
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _handleGetMarkers(LatLng point) async {
    setState(() async {
      final Uint8List markerIcon =
          await getBytesFromAsset('assets/images/car_blue_marker.png', 50);
      BitmapDescriptor bdmark = BitmapDescriptor.fromBytes(markerIcon);
      _markers.clear();
      for (int i = 0; i < 5; i++) {
        LatLng newpoint = point;
        if (i % 4 == 0) {
          newpoint = LatLng(point.latitude + 0.001 * i, point.longitude);
        } else if (i % 4 == 1) {
          newpoint = LatLng(point.latitude, point.longitude + 0.001 * i);
        } else if (i % 4 == 2) {
          newpoint = LatLng(point.latitude - 0.001 * i, point.longitude);
        } else if (i % 4 == 3) {
          newpoint = LatLng(point.latitude, point.longitude - 0.001 * i);
        }
        _markers.add(
          Marker(
            markerId: MarkerId(newpoint.toString()),
            position: newpoint,
            infoWindow: InfoWindow(
              title: 'Car $i',
            ),
            icon: bdmark,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: _markers,
            initialCameraPosition:
                CameraPosition(target: _initialcameraposition, zoom: 15),
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            compassEnabled: true,
            onCameraIdle: _updateCars,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
                child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Notifications()));
                      },
                      child: Icon(Icons.notifications_active),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20, bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: _getcurrentLocation,
                      child: Icon(Icons.navigation),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
