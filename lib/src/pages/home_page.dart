import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currenteIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currenteIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
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