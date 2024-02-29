import 'package:http/http.dart' as http;
import 'dart:convert';

class FCMService {
  static Future<void> sendNotification({
    required String receiverToken,
    String title = "",
    String body = "",
    bool schedule = false,
    DateTime? time,
  }) async {
    // Tạo HTTP request đến FCM endpoint
    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAeqvzpb4:APA91bGMW3Zvip20S3Z96COLxo-UEm4nWxX468qNB8XFVQH1S0ta1mZ3u1uCUM2Zk6LMMznH7b4ONwbDDA-rQctqZj-ulBzszTqSdNR9kKmtkyX8zOlH6CDkWGJVSqLsOkdxlWGGPmD2',
      },
      body: jsonEncode(
        <String, dynamic>{
          'data': <String, dynamic>{
            'title': title,
            'body': body,
            'schedule': schedule,
            'time': time != null ? time.millisecondsSinceEpoch : ""
          },
          'to': receiverToken, // "to": "/topics/ALL",
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully!');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }
}
