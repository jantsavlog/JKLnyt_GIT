import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(62.238838951526844, 25.75458690343214);

  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    // Haetaan JSON-tiedosto
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/test.json';
    final file = File(path);
    final jsonData = json.decode(await file.readAsString());

    // Lisätään markerit kartalle JSON-datan pohjalta
    setState(() {
      _markers = jsonData['events'].map<Marker>((event) {
        return Marker(
          markerId: MarkerId(event['venue']),
          position: LatLng(event['lat'], event['lon']),
          infoWindow: InfoWindow(title: event['venue']),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            print("Marker Tapped");
          },
        );
      }).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      zoomControlsEnabled: true,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
      markers: _markers,
    );
  }
}
