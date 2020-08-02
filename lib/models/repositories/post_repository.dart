import 'dart:io';
import 'package:image_picker/image_picker.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

class PostRepository {
  Future<File> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();

    final pickedImage = uploadType == UploadType.GALLERY
        ? await imagePicker.getImage(source: ImageSource.gallery)
        : await imagePicker.getImage(source: ImageSource.camera);

    return File(pickedImage.path);
  }
}
