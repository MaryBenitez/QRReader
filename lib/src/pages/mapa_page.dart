import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:flutter_map/flutter_map.dart';

class MapaPages extends StatelessWidget {
  final map = new MapController();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Coordenadas QR'),
          actions: [
            IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () {
                  map.move(scan.getLatLng(), 15);
                })
          ],
        ),
        body: _crearFlutterMap(scan));
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scan.getLatLng(), zoom: 15),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoibWFyeWJlIiwiYSI6ImNrZmVpM2NjNTAyYjEzNm9ibmtmOXpibTYifQ.OolHeAr-0pdxPVmP8P0aHA',
          'id': 'mapbox/streets-v11'
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
            width: 100.0,
            height: 100.0,
            point: scan.getLatLng(),
            //Instruccion para que se dibuje el marcador
            builder: (context) => Container(
                  child: Icon(Icons.location_on,
                      size: 55.0, color: Theme.of(context).primaryColor),
                ))
      ],
    );
  }
}
