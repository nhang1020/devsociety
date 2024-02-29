import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devsociety/config/FirebaseNotification.dart';
import 'package:devsociety/controllers/LocalPreference.dart';
import 'package:devsociety/models/Chat.dart';

final _db = FirebaseFirestore.instance;
CollectionReference collectionChat = _db.collection('chat');
CollectionReference collectionStatus = _db.collection('user');

class FirebaseController {
  static Future<void> addMessage(
      Message message, String id, bool oldChat) async {
    try {
      await collectionChat
          .doc(id)
          .set({
            'messages': FieldValue.arrayUnion([
              {
                'content': message.content,
                'senderId': message.senderId,
                'time': message.time,
              }
            ]),
          }, SetOptions(merge: true))
          .then((value) => null)
          .catchError((error) {
            print("=>>>>$error");
          });
    } catch (e) {
      print(e);
    }
  }

  static Stream<QuerySnapshot> getChat(List<String> ids) {
    return collectionChat.where(FieldPath.documentId, whereIn: ids).snapshots();
  }

  static Future<void> changeStatusUser(bool status) async {
    final account = await LocalPreference.localAccount();
    try {
      if (account != null) {
        await collectionStatus.doc('user-${account.user.id}').set({
          'status': status,
          'messageToken': deviceToken,
          'timeUpdate': Timestamp.now(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print("======>$e");
    }
  }

  static Stream<DocumentSnapshot> getStatus(id) {
    return collectionStatus.doc(id).snapshots();
  }
}
