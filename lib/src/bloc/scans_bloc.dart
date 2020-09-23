import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Obtener Scans en la db
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreams =>
      _scansController.stream.transform(validarGeo); //Stream de geolocation
  Stream<List<ScanModel>> get scansStreamsHttp =>
      _scansController.stream.transform(validarHttp);

  dispose() {
    _scansController?.close();
  }

  //Obtener todos los scans
  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  //Agregar Scans
  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  //Borrar Scans
  borrarScan(int id) {
    DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  //Borrar todos los scans
  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }
}
