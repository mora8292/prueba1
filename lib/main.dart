import 'package:flutter/material.dart';
import 'screens/screen_login.dart';
import 'screens/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ScreenHome(), // Cambia a ScreenHome() si quieres iniciar en la pantalla principal
      ),
    );
  }
}
