import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    await firebaseMessaging.requestPermission(
      sound: true,
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
    );
  }

  Future<void> initialise() async {
    await requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);
  }

  Future<void> getFCMToken() async {
    final token = await firebaseMessaging.getToken();
    print(token);
  }

  Future<void> onRefresh(Function(String) onTokenRefersh) async {
    firebaseMessaging.onTokenRefresh.listen((token) {
      onTokenRefersh(token);
    });
  }

  Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeToTopic(String topic) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

Future<void> handleBackgroundNotification(RemoteMessage message) async {}
