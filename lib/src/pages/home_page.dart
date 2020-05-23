import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currenteIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: (){}
          )
        ],
      ),
      body: _callPage(currenteIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR() async{

    //---> https://www.facebook.com
    //---> geo:13.675499538648998,-89.28818121394046

    dynamic futureString ='';
 
    try {
      futureString = await BarcodeScanner.scan();
    }catch(e){
      futureString=e.toString();
    }
 
  print('Future String: ${futureString.rawContent}');
  }

  Widget _callPage(int paginaActual){
    switch(paginaActual){
      case 0:
        return MapasPages();
      case 1:
        return DireccionesPage();

      default:
        return MapasPages();
    }
  }

  //Navegacion entre pantallas
  Widget _crearBottomNavigationBar(){
    return BottomNavigationBar(
      //Controlo las paginas con el int
      currentIndex: currenteIndex,
      //Funcion que cambia entre pantallas
      onTap: (index){
        setState(() {
          currenteIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
      ]
    );
  }
}