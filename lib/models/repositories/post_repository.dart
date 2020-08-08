import 'dart:io';
import 'package:image_picker/image_picker.dart';

// data models
import 'package:insta_clone/data_models/location.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// models
import 'package:insta_clone/models/location/location_manager.dart';
import 'package:insta_clone/models/db/database_manager.dart';

class PostRepository {
  final DatabaseManager databaseManager;
  final LocationManager locationManager;
  PostRepository({this.databaseManager, this.locationManager});

  Future<File> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();

    final pickedImage = uploadType == UploadType.GALLERY
        ? await imagePicker.getImage(source: ImageSource.gallery)
        : await imagePicker.getImage(source: ImageSource.camera);

    return File(pickedImage.path);
  }

  Future<Location> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }
}
