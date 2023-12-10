import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permission for notifications
    NotificationSettings settings = await _messaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    // Subscribe to the 'emergency' topic
    await _messaging.subscribeToTopic('emergency');

    // Handle incoming notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle notification message
      print('Received a notification: ${message.notification?.title}');
      // Update UI or perform other actions based on the notification
    });

    // Handle background notification
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  // Handle background notification
}
