import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// data models
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/data_models/post.dart';

class DatabaseManager {
  final Firestore _db = Firestore.instance;

  Future<bool> searchUserInDB(FirebaseUser firebaseUser) async {
    final query = await _db
        .collection('users')
        .where('userId', isEqualTo: firebaseUser.uid)
        .getDocuments();
    return query.documents.length > 0;
  }

  Future<void> insertUser(User user) async {
    // toMapを用いてユーザー情報をDBで登録する形へ自動変換
    await _db.collection('users').document(user.userId).setData(user.toMap());
  }

  Future<User> getUserInfoFromDbById(String userId) async {
    final query = await _db
        .collection('users')
        .where('userId', isEqualTo: userId)
        .getDocuments();
    return User.fromMap(query.documents.first.data);
  }

  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<void> insertPost(Post post) async {
    // toMapを用いて投稿情報をDBで登録する形へ自動変換
    await _db.collection('posts').document(post.postId).setData(post.toMap());
  }
}
