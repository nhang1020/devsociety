import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  ImageHelper({ImagePicker? imagePicker, ImageCropper? imageCropper})
      : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  Future<List<XFile>> pickImageByGallery({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 50,
    bool mutiple = false,
  }) async {
    if (mutiple) {
      List<XFile>? imageFileList = [];
      final List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
      if (selectedImages!.isNotEmpty) {
        imageFileList.addAll(selectedImages);
      }
      return imageFileList;
    }
    final file = await _imagePicker.pickImage(
        source: source, imageQuality: imageQuality);

    if (file != null) return [file];
    return [];
  }

  Future<List<XFile>> pickImageByCamera({
    ImageSource source = ImageSource.camera,
    int imageQuality = 50,
    bool mutiple = false,
  }) async {
    if (mutiple) {
      return await _imagePicker.pickMultiImage(imageQuality: imageQuality);
    }

    try {
      final file = await _imagePicker.pickImage(
          source: source, imageQuality: imageQuality);
      if (file != null) return [file];
    } catch (e) {
      print("Thiết bị không hỗ trợ");
    }

    return [];
  }

  Future<CroppedFile?> crop(
          {required XFile file,
          CropStyle cropStyle = CropStyle.rectangle}) async =>
      await _imageCropper.cropImage(
        sourcePath: file.path,
        cropStyle: cropStyle,
        compressQuality: 100,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [IOSUiSettings(), AndroidUiSettings()],
      );
}
