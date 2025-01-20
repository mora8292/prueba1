import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  //get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference classes = FirebaseFirestore.instance.collection('courses');
 
  //CREATE: add new note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp':Timestamp.now(),
    });
  }

  Future<void> addClass(String name, String teacherID, String especialidad) {
    return classes.add({
      'name': name,
      'teacher_id': teacherID,
      'id':especialidad,
      'timestamp':Timestamp.now(),
    });
  }
  //READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream= notes.orderBy('timestamp',descending: true).snapshots();
    return notesStream;
  }

  Stream<QuerySnapshot> getUsersStream() {
    final usersStream= users.orderBy('especialidad',descending: true).snapshots();
    return usersStream;
  }

  Stream<QuerySnapshot> getClassesStream() {
    final classesStream= classes.orderBy('timestamp',descending: true).snapshots();
    return classesStream;
  }

  //UPDATE: update notes given a doc id
  Future<void> updateNote(String docID, String newNote){
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  //DELETE: delete notes given a doc id
  Future<void> deleteNote(String docID){
    return notes.doc(docID).delete();
  }
}