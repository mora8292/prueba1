import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  _ScreenLogin createState() => _ScreenLogin();
}

class _ScreenLogin extends State<ScreenLogin> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  final FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;

  @override
  void initState() {
    super.initState();

    // Listener para el primer FocusNode (Email)
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    // Listener para el segundo FocusNode (Contraseña)
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener tamaño de la pantalla
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image con BoxFit.cover
          Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.25, // 25% de la altura de la pantalla
            child: Image.asset(
              'image/image.png',
              fit: BoxFit.cover, // Ajuste de la imagen con BoxFit.cover
            ),
          ),
          SizedBox(height: screenHeight * 0.03), // Separador con 3% del alto

          // TextField "Email"
          Container(
            width: screenWidth * 0.8, // 80% del ancho de la pantalla
            child: TextField(
              focusNode: _focusNode,
              style: TextStyle(
                fontSize: screenWidth * 0.05, // Tamaño dependiente del ancho
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.email_outlined),
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: _isFocused ? const Color(0xfff90741) : Colors.grey, // Color según foco
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfff90741)), // Borde en foco
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03), // Separador con 3% del alto

          // TextField "Contraseña"
          Container(
            width: screenWidth * 0.8, // 80% del ancho de la pantalla
            child: TextField(
              focusNode: _focusNode1,
              obscureText: true, // Ocultar el texto para contraseña
              style: TextStyle(
                fontSize: screenWidth * 0.05, // Tamaño dependiente del ancho
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.key_outlined),
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                  color: _isFocused1 ? const Color(0xfff90741) : Colors.grey, // Color según foco
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfff90741)), // Borde en foco
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05), // Separador con 5% del alto

          // Botón
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xfffa3062),
              textStyle: TextStyle(
                fontSize: screenWidth * 0.05, // Tamaño del texto del botón
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.15, // Botón más amplio
                vertical: screenHeight * 0.02,
              ),
            ),
            onPressed: () {
              // Acción del botón (puedes agregar navegación aquí)
            },
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    super.dispose();
  }
}
