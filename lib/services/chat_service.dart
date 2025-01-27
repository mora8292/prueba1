import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/message.dart';

class ChatService{

  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //get user stream
Stream<List<Map<String, dynamic>>> getUsersStream() {
  return _firestore.collection('users').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
}


  //send message
  Future<void> sendMessage(String receiverId, message) async {
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
   
    //create a new message
Message newMessage = Message(
  senderID: currentUserID,
  senderEmail: currentUserEmail,
  receiverID: receiverId,
  message: message,
  timestamp: timestamp
);


    //construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    //add new message to add database
    await _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    //construct a chat room ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    
    return _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }

}