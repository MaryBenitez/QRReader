import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:flutter_map/flutter_map.dart';

class MapaPages extends StatefulWidget {
  @override
  _MapaPagesState createState() => _MapaPagesState();
}

class _MapaPagesState extends State<MapaPages> {
  final map = new MapController();

  String tipoMapa = 'streets-v11';

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
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context, scan),
    );
  }

  Widget _crearBotonFlotante(BuildContext context, ScanModel scan) {
    return FloatingActionButton(
        child: Icon(Icons.repeat),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          //streets, dark, light, outdoors, satellite
          if (tipoMapa == 'streets-v11') {
            tipoMapa = 'dark-v10';
            print('SUPUESTAMENTE SE CAMBIO A DARK');
          } else if (tipoMapa == 'dark-v10') {
            tipoMapa = 'light-v10';
            print('SUPUESTAMENTE SE CAMBIO A LIGHT');
          } else if (tipoMapa == 'light-v10') {
            tipoMapa = 'outdoors-v11';
            print('SUPUESTAMENTE SE CAMBIO A OUTDOOR');
          } else if (tipoMapa == 'outdoors-v11') {
            tipoMapa = 'satellite-v9';
            print('SUPUESTAMENTE SE CAMBIO A SATELITE');
          } else {
            tipoMapa = 'streets-v11';
            print('SUPUESTAMENTE SE CAMBIO AL PRIMERO');
          }

          //Hace el cambio en pantalla
          setState(() {});

          //movimiento #1 al maximo de zoom
          map.move(scan.getLatLng(), 30);

          //Regreso al Zoom Deseado después de unos Milisegundos
          Future.delayed(Duration(milliseconds: 50), () {
            map.move(scan.getLatLng(), 15);
          });
        });
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
          'id': 'mapbox/$tipoMapa'
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
