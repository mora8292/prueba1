import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firestore.dart';

class TabClass extends StatefulWidget {
  const TabClass({super.key});

  @override
  State<TabClass> createState() => _TabClassState();
  
}

class _TabClassState extends State<TabClass> {
  final TextEditingController textController = TextEditingController();
  String? selectedEspecialidad;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirestoreService firestoreService = FirestoreService();
  void openNoteBox(String? docID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Nombre de la clase',
                    ),
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<QuerySnapshot>(
                    stream: firestoreService.getUsersStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // Obtener una lista de combinaciones únicas de especialidad y grupo
                        final items = snapshot.data!.docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final especialidad =
                              data['especialidad'] ?? 'Sin especialidad';
                          final grupo = data['grupo'] ?? 'Sin grupo';
                          return DropdownMenuItem(
                            value: '$especialidad - $grupo',
                            child: Text('$especialidad - $grupo'),
                          );
                        }).toList();

                        return DropdownButton<String>(
                          isExpanded: true,
                          value: selectedEspecialidad,
                          hint:
                              const Text('Seleccione una especialidad y grupo'),
                          items: items,
                          onChanged: (value) {
                            setState(() {
                              selectedEspecialidad = value;
                            });
                          },
                        );
                      } else{
                        return const Text(
                            'Error al cargar especialidades y grupos');
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isEmpty ||
                  selectedEspecialidad == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, complete todos los campos.'),
                  ),
                );
                return;
              }

              if (docID == null) {
                firestoreService
                    .addClass('${textController.text}', _auth.currentUser!.uid, selectedEspecialidad!);
              } else {
                firestoreService.updateNote(
                    docID, '${textController.text} - $selectedEspecialidad');
              }

              textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(null),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getClassesStream(),
          builder: (context, snaphot) {
            //if we have data, get all the docs
            if (snaphot.hasData) {
              List noteList = snaphot.data!.docs;

              //diasplay as a list
              return ListView.builder(
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  //get each individual doc
                  DocumentSnapshot document = noteList[index];
                  String docID = document.id;

                  //get note from each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['name'];
                  String grupo=data['id'];

                  //display as a list tile
                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            openNoteBox(docID);
                          },
                          icon: Icon(Icons.refresh),
                        ),
                        IconButton(
                            onPressed: () => firestoreService.deleteNote(docID),
                            icon: Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Text('no notes');
            }
          }),
    );
  }
}
