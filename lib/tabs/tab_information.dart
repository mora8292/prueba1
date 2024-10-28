import 'package:flutter/material.dart';

class TabInformation extends StatefulWidget {
  const TabInformation({super.key});

  @override
  State<TabInformation> createState() => _TabInformationState();
}

class _TabInformationState extends State<TabInformation> with TickerProviderStateMixin {
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
    final double imageSize = screenSize.width * 0.25; // 25% del ancho de la pantalla

    return Column(
      children: [
        // Imagen circular
        ClipOval(
          child: Image.asset(
            'image/image.png',
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Name',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 10),
        const Text('Cargo', style: TextStyle(fontSize: 16)),
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
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NSS:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'CURP:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Semester:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildChatButtons(), // Llama a la lista de botones
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Método para construir una lista de botones de chat
  List<Widget> _buildChatButtons() {
    List<Widget> chatButtons = [];
    for (int i = 0; i < chatImages.length; i++) {
      chatButtons.add(_buildChatButton(i));
    }
    return chatButtons;
  }

  // Método para construir un botón de chat
  Widget _buildChatButton(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Espaciado entre botones
      child: ElevatedButton(
        onPressed: () {
          // Acción al presionar el botón del chat
          print('Chat ${index + 1} presionado');
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // Sin padding adicional
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            chatImages[index], // Usa la imagen de la lista
            width: 70, // Ajusta el tamaño de la imagen
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
