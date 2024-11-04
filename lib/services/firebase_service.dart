import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore bd = FirebaseFirestore.instance;

Future<Map<String, dynamic>?> getInformation(String email) async {
  try {
    CollectionReference collectionReferenceInformation = bd.collection('users');

    // Realizar una consulta con filtro de correo electrónico
    QuerySnapshot queryInformation = await collectionReferenceInformation
        .where('email', isEqualTo: email)
        .limit(1) // Usar `limit` para obtener solo el primer resultado coincidente
        .get();

    // Verificar si se encontraron documentos
    if (queryInformation.docs.isNotEmpty) {
      return queryInformation.docs.first.data() as Map<String, dynamic>;
    } else {
      print('No se encontró información para el correo proporcionado.');
      return null;
    }
  } catch (e) {
    print('Error al obtener la información: $e');
    return null;
  }
}
