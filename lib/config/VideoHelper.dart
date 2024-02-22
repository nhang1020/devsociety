import 'package:file_picker/file_picker.dart';

class VideoHelper {
  static Future<String?> pickVideo() async {
    try {
      String? filePath = await FilePicker.platform
          .pickFiles(
            type: FileType.video,
            allowCompression: true,
            allowMultiple: true,
          )
          .then((value) => value?.files.single.path);
      return filePath;
    } catch (e) {
      print("Error picking video: $e");
      return null;
    }
  }
}
