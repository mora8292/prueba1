import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedIndex = 0; // Índice de la pestaña seleccionada

  // Lista de widgets para las diferentes pestañas
  final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Automóvil')),
    const Center(child: Text('Transporte')),
    const Center(child: Text('Bicicleta')),
  ];

  @override
  Widget build(BuildContext context) {
    // Obtener tamaño de la pantalla
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Demo'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // Muestra el widget según el índice seleccionado
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Automóvil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_transit),
            label: 'Transporte',
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
