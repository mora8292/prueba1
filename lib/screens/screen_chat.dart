import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/components/chat_bubble.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/services/chat_service.dart';

class ScreenChat extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
   ScreenChat({super.key, required this.receiverEmail, required this.receiverID});

  //Text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    //if there is something inside the text field

    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(receiverID, _messageController.text);
      //clear text field
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(
            child: _buildMessageList()
            ),
            _builderUserInput(),
          //user input
        ],
        ),
    );
  }
  //build message list
  Widget _buildMessageList() {
   String senderID= _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text('Error');
        } 

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        //return list view
        return ListView(
          children: snapshot.data!.docs.map((doc)=> _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data= doc.data() as Map<String, dynamic>;

    /// is current user
    bool isCurrentUser= data['senderID']== _authService.getCurrentUser()!.uid;

    //align message to the right if sender is the current user, otherwise left
    var alignment= isCurrentUser? Alignment.centerRight: Alignment.centerLeft;
    
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
        ],
      )
      );
  }

  Widget _builderUserInput(){
    return Row(
      children: [
        //text field should take up most of the space
        Expanded(
          child: MyTextfield(
            controller: _messageController,
            hintText: 'Escribe un mensaje',
            obscureText: false,
          ),

        ),
                  //
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
          ),
      ],
    );
  }
}