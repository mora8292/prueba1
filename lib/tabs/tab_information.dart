import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_service.dart';
import 'package:flutter_application_1/widgets/pdf_preview_screen.dart';

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
    final user = FirebaseAuth.instance.currentUser;
    final String? email = user?.email;
    final screenSize = MediaQuery.of(context).size;
    final double imageSize =
        screenSize.width * 0.25; // 25% del ancho de la pantalla

    return FutureBuilder(
      future: getInformation(email!),
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
                          const SizedBox(height: 10),
                          Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data['docs'].length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  data['docs'][index],
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
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

  Future<String> downloadFile(String url) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      // Extrae el nombre del archivo de la URL
      String fileName = url.split('/').last;
      File file = File('${dir.path}/$fileName'); // Usar el nombre extraído
      await Dio().download(url, file.path);
      return file.path;
    } catch (e) {
      print('Error al descargar el archivo: $e');
      throw e; // Propagar el error para manejarlo donde se llame
    }
  }

  Widget _buildFilePreview(String fileUrl) {
    // Aquí puedes verificar la extensión del archivo y decidir cómo mostrarlo
    if (fileUrl.endsWith('.png') ||
        fileUrl.endsWith('.jpg') ||
        fileUrl.endsWith('.jpeg')) {
      // Mostrar imagen si el archivo es una imagen
      return Image.network(
        fileUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else if (fileUrl.endsWith('.pdf')) {
      // Mostrar un icono de PDF si el archivo es un PDF
      return Icon(Icons.picture_as_pdf, size: 50, color: Colors.red);
    } else {
      // Mostrar un icono de archivo genérico si el tipo no es reconocido
      return Icon(Icons.insert_drive_file, size: 50, color: Colors.grey);
    }
  }

  void _downloadOrOpenFile(String fileUrl) {
    // Aquí puedes implementar la lógica para descargar o abrir el archivo
    print('Abrir o descargar archivo desde: $fileUrl');
    // Por ejemplo, podrías usar el paquete url_launcher para abrir el enlace:
    // launch(fileUrl);
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
