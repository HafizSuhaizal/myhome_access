import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permission for notifications
    await _messaging.requestPermission();

    // Subscribe to the 'emergency' topic
    await _messaging.subscribeToTopic('emergency');

    // Handle incoming notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle notification message
      print('Received a notification: ${message.notification?.title}');
      // You can update the UI or perform other actions based on the notification
    });
  }
}