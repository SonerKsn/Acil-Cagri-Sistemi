import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class KonumPage extends StatefulWidget {
  final String lat;
  final String long;
  final int ekipYolda;
  const KonumPage(
      {Key? key,
      required this.lat,
      required this.long,
      required this.ekipYolda})
      : super(key: key);

  @override
  State<KonumPage> createState() => _KonumPageState();
}

double generateRandomValue() {
  Random random = Random();
  double minValue = -0.0075;
  double maxValue = 0.0075;

  double randomValue = minValue + random.nextDouble() * (maxValue - minValue);
  return randomValue;
}

class _KonumPageState extends State<KonumPage> {
  List<Marker> getMarkers() {
    List<Marker> markers = [];
    var mark1 = Marker(
      point: LatLng(double.parse(widget.lat), double.parse(widget.long)),
      builder: (context) {
        return Icon(
          Icons.location_history,
          color: Colors.red,
          size: 25,
        );
      },
    );
    markers.add(mark1);
    if (widget.ekipYolda == 1) {
      var mark2 = Marker(
        point: LatLng(
            double.parse(widget.lat) +
                (widget.ekipYolda == 1 ? generateRandomValue() : 0),
            double.parse(widget.long) +
                (widget.ekipYolda == 1 ? generateRandomValue() : 0)),
        builder: (context) {
          return Icon(
            Icons.local_taxi_rounded,
            color: Colors.blueAccent,
            size: 35,
          );
        },
      );
      markers.add(mark2);
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ekipYolda.toString());
    return Scaffold(
      appBar: AppBar(title: const Text('Konum Bilgileri')),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(double.parse(widget.lat), double.parse(widget.long)),
          zoom: 15,
          maxZoom: 15,
        ),
        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 45,
              size: const Size(40, 40),
              anchor: AnchorPos.align(AnchorAlign.center),
              fitBoundsOptions: const FitBoundsOptions(
                padding: EdgeInsets.all(50),
                maxZoom: 15,
              ),
              markers: getMarkers(),
              builder: (context, markers) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
