import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// data models
import 'package:insta_clone/data_models/location.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

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

  Future<Location> updateLocation(double latitude, double longitude) async {
    return await locationManager.updateLocation(latitude, longitude);
  }

  // 投稿処理
  Future<void> executePost({
    User currentUser,
    File imageFile,
    String caption,
    Location location,
    String locationString,
  }) async {
    final String storageId = Uuid().v1();
    final String imageUrl =
        await databaseManager.uploadImageToStorage(imageFile, storageId);
    final post = Post(
      postId: Uuid().v1(),
      userId: currentUser.userId,
      imageUrl: imageUrl,
      imageStoragePath: storageId,
      caption: caption,
      locationString: locationString,
      latitude: location.latitude,
      longitude: location.longitude,
      postDateTime: DateTime.now(),
    );
    await databaseManager.insertPost(post);
  }
}
