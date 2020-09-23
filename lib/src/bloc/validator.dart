import 'dart:async';

import 'package:qrreaderapp/src/models/scan_model.dart';

class Validators {
  //Para Geo
  final validarGeo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    //Generando salida del transformer
    final geoScans = scans.where((s) => s.tipo == 'geo').toList();
    sink.add(geoScans);
  });

  //Para Http
  final validarHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    //Generando salida del transformer
    final geoScans = scans.where((s) => s.tipo == 'http').toList();
    sink.add(geoScans);
  });
}
