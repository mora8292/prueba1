import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/animations/animation_entry.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });
  }

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnimationEntry()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Correo/Contraseña incorrectos'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenHeight = constraints.maxHeight;
          final double screenWidth = constraints.maxWidth;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  SizedBox(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.2,
                    child: Image.asset(
                      'image/image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Email Input
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      controller: _emailController,
                      focusNode: _focusNode,
                      style: TextStyle(fontSize: screenWidth * 0.045),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.email_outlined),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: _isFocused ? const Color(0xfff90741) : Colors.grey,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff90741)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Password Input
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      controller: _passwordController,
                      focusNode: _focusNode1,
                      obscureText: true,
                      style: TextStyle(fontSize: screenWidth * 0.045),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.key_outlined),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(
                          color: _isFocused1 ? const Color(0xfff90741) : Colors.grey,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff90741)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfffa3062),
                      textStyle: TextStyle(fontSize: screenWidth * 0.045),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.2,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                    onPressed: _signIn,
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}