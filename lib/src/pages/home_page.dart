import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currenteIndex = 0;

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanTodos,
          )
        ],
      ),
      body: _callPage(currenteIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  //Aqui lee la informacion del codigo QR
  _scanQR(BuildContext context) async {
    //---> https://www.facebook.com
    //---> geo:13.675499538648998,-89.28818121394046

    //dynamic futureString ='';

    ScanResult futureString;

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString(context);
    }

    print('Future String: ${futureString.rawContent}');

    if (futureString != null) {
      final scan = ScanModel(valor: futureString.rawContent);
      scansBloc.agregarScan(scan);

      print('Tenemos informacion');

      //Por problema en IOS
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      } else {
        utils.abrirScan(context, scan);
      }

      utils.abrirScan(context, scan);
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPages();
      case 1:
        return DireccionesPage();

      default:
        return MapasPages();
    }
  }

  //Navegacion entre pantallas
  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
        //Controlo las paginas con el int
        currentIndex: currenteIndex,
        //Funcion que cambia entre pantallas
        onTap: (index) {
          setState(() {
            currenteIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
          BottomNavigationBarItem(
              icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
        ]);
  }
}
