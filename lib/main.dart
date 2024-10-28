import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/animations/animation_entry.dart';
import 'screens/screen_login.dart';
import 'screens/screen_home.dart';
import 'firebase_options.dart'; // Asegúrate de que este archivo esté generado

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ScreenHome(), // Cambia a ScreenHome() si quieres iniciar en la pantalla principal
      ),
    );
  }
}
