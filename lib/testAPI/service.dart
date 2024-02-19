import 'dart:io';
import 'package:devsociety/config/httpBaseClient.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:google_sign_in/google_sign_in.dart';

class DriveService {
  final _authService = AuthService();
  static final _instance = DriveService._();

  DriveService._();

  factory DriveService() {
    return _instance;
  }

  Future uploadFile(String fileName, String filePath) async {
    final file = File(filePath);

    final headers = await _authService.googleSignIn();
    if (headers == null) return null;

    final client = DriveClient(headers);
    final drive = ga.DriveApi(client);

    final fileId = await _getFileID(drive, fileName);
    if (fileId == null) {
      final res = await drive.files.create(
        ga.File()..name = fileName,
        uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
      );
      return res.id;
    } else {
      final res = await drive.files.update(
        ga.File()..name = fileName,
        fileId,
        uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
      );
      return res;
    }
  }

  Future<String?> _getFileID(ga.DriveApi drive, String fileName) async {
    final list = await drive.files.list(q: "name: '$fileName'", pageSize: 1);
    if (list.files?.isEmpty ?? true) return null;
    return list.files?.first.id;
  }

  Future<String?> downloadFile(String fileId, String filePath) async {
    // 1. sign in with Google to get auth headers
    final headers = await _authService.googleSignIn();
    if (headers == null) return null;
    // 2. create auth http client & pass it to drive API
    final client = DriveClient(headers);
    final drive = ga.DriveApi(client);
    // 3. download file from the google drive
    final res = await drive.files.get(
      fileId,
      downloadOptions: ga.DownloadOptions.fullMedia,
    ) as ga.Media;
    // 4. convert downloaded file stream to bytes
    final bytesArray = await res.stream.toList();
    List<int> bytes = [];
    for (var arr in bytesArray) {
      bytes.addAll(arr);
    }
    // 5. write file bytes to disk
    await File(filePath).writeAsBytes(bytes);
    return filePath;
  }
}

class AuthService {
  static final _instance = AuthService._();
  final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/drive.file'],
  );

  AuthService._();

  factory AuthService() {
    return _instance;
  }

  Future<Map<String, String>?> googleSignIn() async {
    try {
      GoogleSignInAccount? googleAccount;
      if (_googleSignIn.currentUser == null) {
        googleAccount = await _googleSignIn.signIn();
      } else {
        googleAccount = await _googleSignIn.signInSilently();
      }

      return await googleAccount?.authHeaders;
    } catch (e) {
      return null;
    }
  }

  Future<void> googleSignOut() => _googleSignIn.signOut();
}
