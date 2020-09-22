//Base de datos

import 'dart:io';
import 'package:path/path.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  //Solo una instancia de manera global
  static Database _database; //--> Instancia a la base de datos
  static final DBProvider db = DBProvider._(); //-->Constructor privado

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    //El path de donde se encuentra la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //Direccion donde se encontrara la db mas el nombre del archivo con ext 'db'
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        //Ya esta creada la db y lista para usarse
        onCreate: (Database db, int version) async {
      //Primera tabla de la db
      await db.execute('CREATE TABLE Scans('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')');
    });
  }

  //Crear registros
  nuevoScanRaw(ScanModel nuevoScan) async {
    //Verificar si tenemos lista la db y escribir dentro de ella
    final db = await database;

    //------Proceso de insercion
    //Obtengo la respuesta o el resultado de la insercion
    final res = await db.rawInsert(
        "INSERT into Scans (id, tipo, valor) " //--> Importante dejar el espacio al final
        "VALUES ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}' )");
    return res;
  }

////----ESTA SINTAXIS ES MAS SEGURA----////

//Crear registro
  nuevoScan(ScanModel nuevoScan) async {
    //Verificar si tenemos lista la db y escribir dentro de ella
    final db = await database;

    //INSERT -- Proceso de insercion
    //Obtengo la respuesta o el resultado de la insercion
    final res = await db.insert('Scans',
        nuevoScan.toJson()); //--> Transforma el modelo y regresa un mapa
    return res;
  }

  //SELECT -- Obtener información
  Future<ScanModel> getScanId(int id) async {
    
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    //La primera posicion
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }
}