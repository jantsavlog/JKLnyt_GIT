import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jklnyt/event.dart';
import 'package:jklnyt/events_provider.dart';
import 'package:provider/provider.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  GoogleMapWidgetState createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(62.238838951526844, 25.75458690343214);

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    List<Event> events = Provider.of<EventsProvider>(context).shownEvents;
    return GoogleMap(
      onMapCreated: _onMapCreated,
      zoomControlsEnabled: false,
      compassEnabled: false,
      myLocationButtonEnabled: false,
      rotateGesturesEnabled: false,
      initialCameraPosition: const CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
      markers: events.map<Marker>((event) {
        return Marker(
          markerId: MarkerId(event.info['venue']),
          position: LatLng(event.info['lat'], event.info['lon']),
          infoWindow: InfoWindow(title: event.info['venue']),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            //print("Marker Tapped");
          },
        );
      }).toSet(),
    );
  }
}
