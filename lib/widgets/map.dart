import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/termin.dart';
import 'package:geocoding/geocoding.dart';

class Map extends StatefulWidget {
  final List<Termin> termini;

  const Map({super.key, required this.termini});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  Future<Location> getAddressCoordinates(String address) async {
    List<Location> locations = await locationFromAddress(address);
    Location location = locations.first;
    return location;
  }

  List<Marker> _getMarkers() {
    List<Marker> markers = [];

    for (int i = 0; i < widget.termini.length; i++) {
      Termin termin = widget.termini[i];
      Future<Location> location = getAddressCoordinates(termin.position);

      location.then((value) => markers.add(Marker(
          point: LatLng(value.latitude, value.longitude),
          child: GestureDetector(
            onTap: () {
              // Show the alert dialog here
              _displayAlertDialog(value.latitude, value.longitude);
            },
            child: const Icon(Icons.pin_drop_outlined),
          ))));
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("This is the map:"),
        ),
        body: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(41.99, 21.40),
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'AndroidStudioProjects.auth5',
            ),
            MarkerLayer(markers: _getMarkers())
          ],
        ));
  }

  Future<void> _displayAlertDialog(double latitude, double longitude) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to launch Google Maps ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Abort'),
            ),
            TextButton(
              onPressed: () async {
                final String googleMapsUrl =
                    'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

                final Uri uri = Uri.parse(googleMapsUrl);

                await launchUrl(uri);

                Navigator.of(context).pop();
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
