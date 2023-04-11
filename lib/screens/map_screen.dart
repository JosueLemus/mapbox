import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    '';

final points = <LatLng>[
  LatLng(-17.756537, -63.200079),
  LatLng(-17.760459, -63.151868),
  LatLng(-17.820320, -63.173914),
  LatLng(-17.812363, -63.207952),
  LatLng(-17.756537, -63.200079),
];

List<Marcador> markersList = [
  Marcador('https://cdn-icons-png.flaticon.com/512/3410/3410124.png',
      LatLng(-17.782857, -63.181043)),
  Marcador('https://static.vecteezy.com/system/resources/previews/018/869/038/original/traffic-light-transparent-background-png.png',
      LatLng(-17.784782, -63.195030)),
  Marcador('https://cdn-icons-png.flaticon.com/512/1282/1282259.png',
      LatLng(-17.769051, -63.164187)),
];

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Mapa')),
      body: FlutterMap(
        options: MapOptions(
            center: markersList[0].point,zoom: 18),
        nonRotatedChildren: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox/streets-v12'
            },
          ),
          PolygonLayer(
            polygons: [
              Polygon(
                  points: points,
                  isFilled: true,
                  color: Colors.red.withOpacity(0.5))
            ],
          ),
          MarkerLayer(
              markers: markersList.map((element) {
            return Marker(
                point: element.point,
                width: 40,
                height: 40,
                builder: (context) {
                  return Image.network(element.imgUrl);
                });
          }).toList()),
        ],
      ),
    );
  }
}

class Marcador {
  final String imgUrl;
  final LatLng point;

  Marcador(this.imgUrl, this.point);
}
