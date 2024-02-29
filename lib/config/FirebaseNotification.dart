import 'dart:convert';

import 'package:devsociety/config/NotificationHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var deviceToken;

class FirebaseMessageApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  @pragma('vm:entry-point')
  static Future<void> handleOnBackgroundMessage(RemoteMessage message) async {
    try {
      final data = message.data;

      final notification = RemoteNotification.fromMap(data);

      await NotificationHelper.simpleNotification(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        payload: jsonEncode(message.toMap()),
        // showImage: true,
      );
    } catch (e) {
      await NotificationHelper.simpleNotification(title: e.toString());
    }
  }

  void hanldeMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.getInitialMessage().then(hanldeMessage);
    await FirebaseMessaging.onMessageOpenedApp.listen(hanldeMessage);
    FirebaseMessaging.onBackgroundMessage(await handleOnBackgroundMessage);

    await FirebaseMessaging.onMessage.listen((message) async {
      final data = message.data;
      final notification = RemoteNotification.fromMap(data);
      // print(jsonEncode(message));
      await NotificationHelper.simpleNotification(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        payload: jsonEncode(message.toMap()),
        // showImage: true,
      );
    });
  }

  //

  Future<void> initNotification() async {
    await NotificationHelper().initNotification();
    await _firebaseMessaging.requestPermission();
    await FirebaseMessaging.instance.subscribeToTopic("ALL");
    deviceToken = await _firebaseMessaging.getToken();
    initPushNotification();
    print(deviceToken);
  }
}
