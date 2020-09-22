import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Obtener Scans en la db
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreams => _scansController.stream;

  dispose() {
    _scansController?.close();
  }
}
