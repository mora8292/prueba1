import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_service.dart';
import 'package:flutter_application_1/tabs/tab_information.dart';
import 'package:flutter_application_1/tabs/tab_news.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/tabs/tab_teacher.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});


  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedIndex = 0; // Índice de la pestaña seleccionada
  String _role = 'student'; // Rol predeterminado
  late List<Widget> _widgetOptions=[]; // Lista de widgets para las pestañas

  @override
  void initState() {
    super.initState();
    _initializeRole(); // Inicializar el rol del usuario
  }

  Future<void> _initializeRole() async {
    final user = FirebaseAuth.instance.currentUser;
    final String? email = user?.email;

    if (email != null) {
      // Obtén el rol del usuario desde Firebase (reemplaza `getInformation` con tu función de datos)
      final data = await getInformation(email);
      setState(() {
        _role = data?['role'] ?? 'student'; // Asigna el rol o usa un valor predeterminado
        _widgetOptions = _getWidgetOptionsByRole(_role); // Configura las pestañas según el rol
      });
    }
  }

  List<Widget> _getWidgetOptionsByRole(String role) {
    if (role == 'Profesor') {
      return [
        const TabTeacher(),
        const TabNews(),
        const Center(child: Text('Gestión de Clases')),
      ];
    } else {
      // Rol de estudiante o valor predeterminado
      return [
        const TabInformation(),
        const TabNews(),
        const Center(child: Text('Bicicleta')),
      ];
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Una vez que el usuario cierra sesión, redirige a la pantalla de inicio de sesión
      Navigator.of(context).pushReplacementNamed('/ScreenLogin');
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambia el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CBapp'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(onPressed: _signOut, icon: const Icon(Icons.settings)),
        ],
      ),
      body: _widgetOptions.isNotEmpty
          ? Center(child: _widgetOptions.elementAt(_selectedIndex))
          : const Center(child: CircularProgressIndicator()), // Indicador de carga mientras se obtienen las pestañas
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
            label: 'Más',
          ),
        ],
        currentIndex: _selectedIndex, // Índice de la pestaña seleccionada
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, // Función llamada al seleccionar una pestaña
      ),
    );
  }
}
