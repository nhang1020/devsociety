import 'dart:io';
import 'package:devsociety/config/httpBaseClient.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';

class DriveService {
  final _authService = AuthDriveService();
  static final _instance = DriveService._();

  DriveService._();

  factory DriveService() {
    return _instance;
  }
  static String displayDrivePhoto(String id) {
    return "https://drive.google.com/uc?export=view&id=$id";
  }

  Future<List<String>> uploadFiles(List<File> files) async {
    final headers = await _authService.googleSignIn();
    if (headers == null) return [];

    final client = DriveClient(headers);
    final drive = ga.DriveApi(client);

    final folder = await _getOrCreateFolder(drive, "images");

    final uploadTasks = files.map((file) async {
      // final fileId = await _getFileID(drive, basename(file.path));
      final media = ga.Media(file.openRead(), file.lengthSync());
      final fileName = basename(file.path);
      final res = await drive.files.create(
        ga.File()
          ..name = "$fileName${DateTime.now().microsecondsSinceEpoch}"
          ..parents = [folder!],
        uploadMedia: media,
      );
      return res.id!;
      // if (fileId == null) {
      //   final res = await drive.files.create(
      //     ga.File()
      //       ..name = fileName
      //       ..parents = [folder!],
      //     uploadMedia: media,
      //   );
      //   return res.id!;
      // } else {
      //   final res = await drive.files.update(
      //     ga.File()..name = fileName,
      //     fileId,
      //     uploadMedia: media,
      //   );
      //   return res.id!;
      // }
    });

    final uploadedFileIds = await Future.wait(uploadTasks);

    return uploadedFileIds;
  }

  Future<String?> _getFileID(ga.DriveApi drive, String fileName) async {
    final list = await drive.files.list(q: "name: '$fileName'", pageSize: 1);
    if (list.files?.isEmpty ?? true) return null;
    return list.files?.first.id;
  }

  Future<String?> _getOrCreateFolder(
      ga.DriveApi drive, String folderName) async {
    final folderId = "1bWn3NAx6y8E7J_FJUCoAcGxTjDXBYduQ";
    if (folderId != "") {
      return folderId;
    } else {
      // Nếu không, tạo thư mục mới
      final res = await drive.files.create(
        ga.File()
          ..name = folderName
          ..mimeType = "application/vnd.google-apps.folder",
      );
      return res.id;
    }
  }

  Future<String?> getFolderID(ga.DriveApi drive, String folderName) async {
    final files = await drive.files.list(
        q: "mimeType='application/vnd.google-apps.folder' and name='$folderName'");
    if (files.files!.isNotEmpty) {
      print(files.files!.first.id);
      return files.files!.first.id;
    } else {
      return null;
    }
  }
}

class AuthDriveService {
  static final _instance = AuthDriveService._();
  final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/drive.file'],
  );

  AuthDriveService._();

  factory AuthDriveService() {
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
