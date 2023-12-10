import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import '../Model/notification.dart';


class NotificationManager with ChangeNotifier {
  List<NotificationModel> notifications = [];

  void addNotification(NotificationModel notification) {
    notifications.add(notification);
    notifyListeners();
  }
}

class NotificationController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final NotificationManager manager;

  NotificationController(this.manager);

  Future<void> initNotifications() async {
    NotificationSettings settings = await _messaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    await _messaging.subscribeToTopic('emergency');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      manager.addNotification(NotificationModel(
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        imageUrl: message.notification?.android?.imageUrl,
      ));
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}
