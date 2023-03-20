import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center =
      const LatLng(62.238838951526844, 25.75458690343214);

  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("Tanssisali Lutakko"),
          position: LatLng(62.23925997182314, 25.755441596589883),
          infoWindow: InfoWindow(title: 'Tanssisali Lutakko'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            print("Marker Tapped");
          },
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId("Paviljonki"),
          position: LatLng(62.24032454287783, 25.758254214686037),
          infoWindow: InfoWindow(title: 'Paviljonki'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            print("Marker Tapped");
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
      markers: _markers,
    );
  }
}
