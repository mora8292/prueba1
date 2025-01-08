import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/animations/animation_entry.dart';
import 'package:flutter_application_1/screens/screen_login.dart';
import 'package:flutter_application_1/screens/screen_home.dart';
import 'package:flutter_application_1/services/firebase_api.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseApi().initNotifications();
  } catch (e) {
    print('Error al inicializar Firebase: $e');
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/ScreenLogin': (context) =>
            const ScreenLogin(), // Define aquí tu pantalla de inicio de sesión
      },
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        // Escuchar los cambios en el estado de autenticación
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            // Si el usuario está autenticado, ir a ScreenHome
            return const AnimationEntry();
          } else {
            // Si no hay usuario autenticado, ir a ScreenLogin
            return const ScreenLogin();
          }
        },
      ),
    );
  }
}
