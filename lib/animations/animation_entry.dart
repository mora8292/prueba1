import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/screen_home.dart';
import 'package:flutter_application_1/services/firebase_service.dart';

class AnimationEntry extends StatefulWidget {
  const AnimationEntry({super.key});

  @override
  _AnimationEntryState createState() => _AnimationEntryState();
}

class _AnimationEntryState extends State<AnimationEntry>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    // Configuramos un temporizador para cambiar de pantalla después de la animación
    Future.delayed(const Duration(milliseconds: 2300), () {
      setState(() => _isVisible = false);
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenHome()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;
    final String? email = user?.email;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShakeTransition(
                      offset: screenHeight * 0.1,
                      child: Rotation3DTransition(
                        child: Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.25,
                          child: Image.asset(
                            'image/image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        duration: Duration(milliseconds: 1500),
                      ), // Adaptamos el offset para mejorar la animación
                    ),
                    ShakeTransition(
                      offset: screenHeight * 0.1,
                      child: FutureBuilder(
                        future: getInformation(email!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.hasData) {
                              final data =
                                  snapshot.data as Map<String, dynamic>;
                              return Center(
                                child: Text(
                                  'Bienvenido \n${data['name']}',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            } else {
                              return const Text('Error al cargar la información');
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'CBAPP',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShakeTransition extends StatelessWidget {
  const ShakeTransition({
    super.key,
    required this.offset,
    this.duration = const Duration(milliseconds: 800),
    required this.child,
    this.axis = Axis.vertical,
  });

  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: duration,
      curve: Curves.bounceInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(value * offset, 0.0)
              : Offset(0.0, value * offset),
          child: child,
        );
      },
      child: child,
    );
  }
}

class Rotation3DTransition extends StatelessWidget {
  const Rotation3DTransition({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Configuración para la rotación 3D
            ..rotateY(2 * 3.14159 * value), // Rotación en el eje Y
          child: child,
        );
      },
      child: child,
    );
  }
}
