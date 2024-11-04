import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkSession() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false; // Devuelve false si no se ha guardado nada
}

Future<void> logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn'); // O usa prefs.clear() para borrar todo
  // Navegar de vuelta a la pantalla de inicio de sesión
}
