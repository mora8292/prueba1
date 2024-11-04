import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_service.dart';

class TabInformation extends StatefulWidget {
  const TabInformation({super.key});

  @override
  State<TabInformation> createState() => _TabInformationState();
}

class _TabInformationState extends State<TabInformation>
    with TickerProviderStateMixin {
  late TabController _secondaryTabController;

  // Lista de imágenes de chat
  final List<String> chatImages = [
    'image/image.png',
    'image/image.png',
    'image/image.png',
  ];

  @override
  void initState() {
    super.initState();
    _secondaryTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _secondaryTabController.dispose();
    super.dispose();
  }

  Widget _buildContent() {
    // Obtiene el tamaño de la pantalla
    final screenSize = MediaQuery.of(context).size;
    final double imageSize =
        screenSize.width * 0.25; // 25% del ancho de la pantalla

    return FutureBuilder(
      future: getInformation("frijolito@dgeti.edu.mx"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            final data = snapshot.data as Map<String, dynamic>;
            return Column(
              children: [
                // Imagen circular
                ClipOval(
                  child: Image.network(
                    '${data['profile_picture']}',
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${data['name']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Cargo: ${data['role']}',
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 10),
                TabBar(
                  controller: _secondaryTabController,
                  tabs: const [
                    Tab(text: 'General'),
                    Tab(text: 'Chats'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _secondaryTabController,
                    children: [
                      // Sección General
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NSS: ${data['nss']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'CURP: ${data['curp']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Especialidad: ${data['especialidad']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Semestre: ${data['semestre']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Grupo: ${data['grupo']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // Sección de Chats
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _buildChatButtons(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No se encontró información'));
          }
        }
      },
    );
  }

  // Método para construir una lista de botones de chat
  List<Widget> _buildChatButtons() {
    return chatImages.map((imagePath) => _buildChatButton(imagePath)).toList();
  }

  // Método para construir un botón de chat
  Widget _buildChatButton(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Espaciado entre botones
      child: ElevatedButton(
        onPressed: () {
          // Acción al presionar el botón del chat
          print('Botón de chat presionado');
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }
}
