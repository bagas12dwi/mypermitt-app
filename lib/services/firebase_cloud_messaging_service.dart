import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permit_app/services/firebase_service.dart';
import 'package:permit_app/services/local_notification_service.dart';

class FirebaseCloudMessagingService {
  static Future<void> listenFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen(onForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  }

  static Future<void> onForegroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      LocalNotificationService.scheduleNotification(title: message.notification?.title, body: message.notification?.body);
    }
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firebase Messaging,
    // make sure you call initializeApp before using other Firebase services.
    await FirebaseService.initializeApp();

    if (message.notification != null) {
      LocalNotificationService.scheduleNotification(title: message.notification?.title, body: message.notification?.body);
    }
  }

  static Future<String?> getFcmToken() => FirebaseMessaging.instance.getToken();
}