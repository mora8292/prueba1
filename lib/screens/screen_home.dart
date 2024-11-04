import 'package:flutter/material.dart';
import 'package:flutter_application_1/tabs/tab_information.dart';
import 'package:flutter_application_1/tabs/tab_news.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedIndex = 0; // Índice de la pestaña seleccionada

  // Lista de widgets para las diferentes pestañas
  final List<Widget> _widgetOptions = <Widget>[
    const TabInformation(),
    const TabNews(),
    const Center(child: Text('Bicicleta')),
  ];

  @override
  Widget build(BuildContext context) {
    // Obtener tamaño de la pantalla
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CBapp'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.settings)),

        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // Muestra el widget según el índice seleccionado
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: 'Information',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike),
            label: 'Bicicleta',
          ),
        ],
        currentIndex: _selectedIndex, // Índice de la pestaña seleccionada
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, // Función llamada al seleccionar una pestaña
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambia el índice seleccionado
    });
  }
}
