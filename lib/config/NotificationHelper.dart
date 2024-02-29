import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tZ;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static BehaviorSubject<String?> onNotification = BehaviorSubject<String?>();
  Future<void> initNotification() async {
    tZ.initializeTimeZones();
    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@drawable/launcher_icon');
    DarwinInitializationSettings iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    final details = await notificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.notificationResponse!.payload);
    }
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        onNotification.add(details.payload);
      },
      onDidReceiveBackgroundNotificationResponse:
          HandleNotification.onSelectNotification,
    );
  }

  static Future _notificationDetails(
      {bool showImage = false, String? payload}) async {
    // var bigPicturePath =
    //     await Utils.convertToBase64("assets/icons/congratulation.png");
    // final largeIconPath = await Utils.convertToVase64("");

    // final styleInformation = BigPictureStyleInformation(
    //   ByteArrayAndroidBitmap.fromBase64String(bigPicturePath),
    //   htmlFormatContent: true,
    //   // largeIcon: FilePathAndroidBitmap(largeIconPath),
    // );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'Channel_id',
        'Channel_title',
        priority: Priority.high,
        importance: Importance.max,
        channelShowBadge: true,
        largeIcon: DrawableResourceAndroidBitmap("@drawable/launcher_icon"),
        color: myColor,
        colorized: true,
        // styleInformation: showImage ? styleInformation : null,
        styleInformation: BigTextStyleInformation('', htmlFormatContent: true),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future<dynamic> simpleNotification(
      {int id = 0,
      String? title,
      String? body,
      bool showImage = false,
      String? payload}) async {
    await notificationsPlugin.show(
        id,
        title,
        body,
        await _notificationDetails(
            showImage: showImage, payload: payload ?? ""),
        payload: payload);
    return payload;
  }

  static Future scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime date,
  }) async {
    // DateTime _dateTime = DateTime(
    //     date.year, date.month, date.day, time.hour, time.minute, date.second);
    // print("Lich: ${date}");
    return notificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(date, tz.local), await _notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }

  static Future cancelAll() async => await notificationsPlugin.cancelAll();
  static Future cancel({required int id}) async =>
      await notificationsPlugin.cancel(id);
}

class HandleNotification {
  static void onSelectNotification(NotificationResponse details) async {
    final payload = details.payload;
    print(payload);
  }
}
