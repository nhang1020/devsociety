// import 'dart:convert';
// import 'dart:io';
// import 'package:devsociety/firebase_options3.dart';
// import 'package:devsociety/testAPI/service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const GoogleDriveApp());
// }

// class GoogleDriveApp extends StatefulWidget {
//   const GoogleDriveApp({super.key});

//   @override
//   State<GoogleDriveApp> createState() => _GoogleDriveAppState();
// }

// class _GoogleDriveAppState extends State<GoogleDriveApp> {
//   var _fileId;
//   final _driveService = DriveService();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         key: _scaffoldKey,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: _downloadFile,
//                 child: const Text('Upload File'),
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// dummy method to showcase uploading of file to google drive
//   Future<void> _uploadFile() async {
//     _showLoader();

//     // 1. create a file to upload
//     final dir = await getApplicationDocumentsDirectory();
//     final filePath = path.join(dir.path, 'upload.txt');
//     final file = File(filePath);
//     await file.writeAsString('Hello World!!!');

//     // 2. upload file to drive
//     // _fileId = await _driveService.uploadFile('upload.txt', filePath);

//     _closeLoader();

//     if (_fileId == null) {
//       _showSnackbar('Failed to upload the file!');
//     } else {
//       _showSnackbar('File successfully uploaded: ${jsonEncode(_fileId)}');
//       print(jsonEncode(_fileId));
//     }
//   }
//   Future<void> _downloadFile() async {
//     if (_fileId == null) {
//       _showSnackbar('Upload a file first!');
//       return;
//     }
//     _showLoader();
//     // 1. create a path to download the file
//     final dir = await getApplicationDocumentsDirectory();
//     final filePath = path.join(dir.path, 'download.txt');
//     // 2. download the file
//     final id = await _driveService.downloadFile(_fileId!, filePath);
//     // 3. read downloaded file content
//     final content = await File(filePath).readAsString();
//     _closeLoader();
//     if (id == null) {
//       _showSnackbar('Failed to download the file!');
//     } else {
//       _showSnackbar('File successfully downloaded: $content');
//     }
//   }
//   void _showSnackbar(String msg) {
//     ScaffoldMessenger.of(_scaffoldKey.currentContext!)
//         .showSnackBar(SnackBar(content: Text(msg)));
//   }

//   void _showLoader() {
//     showDialog(
//       context: _scaffoldKey.currentContext!,
//       barrierDismissible: false,
//       builder: (context) => Dialog(
//         child: Container(
//           width: 200,
//           height: 200,
//           alignment: Alignment.center,
//           child: const CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }

//   void _closeLoader() {
//     Navigator.pop(_scaffoldKey.currentContext!);
//   }
// }
