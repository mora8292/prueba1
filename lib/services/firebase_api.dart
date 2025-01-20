import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/main.dart';

class FirebaseApi{
  //create an instance of FirebaseMessaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notifications
Future<void> initNotifications() async {
  /*
  await _firebaseMessaging.requestPermission();

  try {
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      print('FCM Token: $fCMToken');
    } else {
      print('Failed to get FCM Token.');
    }
  } catch (e) {
    print('Error fetching FCM token: $e');
  }

  initPushNotifications();
  */
}


  //function to handle received messages
  void handleMessages(RemoteMessage? message) {
   // if the message is null, do nothing
   if (message == null) {
     return;
   }

   //navigate to new screen when message is received and user taps notification
   navigatorKey.currentState?.pushNamed(
    '/ScreenNotification',
    arguments: message,
    );
   
  }

  //function to initialize foreground and background settings
  Future initPushNotifications() async {
    //handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);

    //attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
   }
}