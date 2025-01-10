import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ScreenNotification extends StatelessWidget {
  const ScreenNotification({super.key});

  @override
  Widget build(BuildContext context) {
    //get the notification messsge and display on screen
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: 
       Column(
        children: [
          Text(message.notification!.title.toString()),
          Text(message.notification!.body.toString()),
          Text(message.data.toString()),
          ]
      ),
    );
  }
}