import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// data models
import 'package:insta_clone/data_models/comment.dart';
import 'package:insta_clone/data_models/like.dart';
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

  Future<List<Post>> getMyselfAndFollowingUsersPosts(String myUserId) async {
    final query = await _db.collection('posts').getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    List<String> userIds = await _getFollowingUserIds(myUserId);
    userIds.add(myUserId);

    return await _db
        .collection('posts')
        .where('userId', whereIn: userIds)
        .orderBy('postDateTime', descending: true)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map((DocumentSnapshot snapshot) => Post.fromMap(snapshot.data))
              .toList(),
        );
  }

  Future<List<Post>> getProfileUserPosts(String profileUserId) async {
    final query = await _db.collection('posts').getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    return await _db
        .collection('posts')
        .where('userId', isEqualTo: profileUserId)
        .orderBy('postDateTime', descending: true)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map((DocumentSnapshot snapshot) => Post.fromMap(snapshot.data))
              .toList(),
        );
  }

  Future<List<String>> _getFollowingUserIds(String userId) async {
    final query = await _db
        .collection('users')
        .document(userId)
        .collection('followings')
        .getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    return query.documents
        .map((DocumentSnapshot snapshot) => snapshot.data['userId']);
  }

  Future<void> updatePost(Post updatedPost) async {
    final DocumentReference reference =
        _db.collection('posts').document(updatedPost.postId);
    await reference.updateData(updatedPost.toMap());
  }

  Future<void> postComment(Comment comment) async {
    await _db
        .collection('comments')
        .document(comment.commentId)
        .setData(comment.toMap());
  }

  Future<List<Comment>> getComments(String postId) async {
    final query = await _db.collection('comments').getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    return await _db
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('commentDateTime')
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map(
                (DocumentSnapshot snapshot) => Comment.fromMap(snapshot.data),
              )
              .toList(),
        );
  }

  Future<void> deleteComment(String deleteCommentId) async {
    final reference = _db.collection('comments').document(deleteCommentId);
    await reference.delete();
  }

  Future<void> likeIt(Like like) async {
    await _db.collection('likes').document(like.likeId).setData(like.toMap());
  }

  Future<void> unLikeIt(Post post, User currentUser) async {
    await _db
        .collection('likes')
        .where('likedPostId', isEqualTo: post.postId)
        .where('likeUserId', isEqualTo: currentUser.userId)
        .getDocuments()
        .then(
          (QuerySnapshot snapshot) =>
              snapshot.documents.first.reference.delete(),
        );
  }

  Future<List<Like>> getLikeResult(String likedPostId) async {
    final query = await _db.collection('likes').getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    return await _db
        .collection('likes')
        .where('likedPostId', isEqualTo: likedPostId)
        .orderBy('likeDateTime')
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map((DocumentSnapshot snapshot) => Like.fromMap(snapshot.data))
              .toList(),
        );
  }

  Future<void> deletePost(String postId, String imageStoragePath) async {
    // delete post
    await _db.collection('posts').document(postId).delete();

    // delete comment
    await _db
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents.forEach(
            (DocumentSnapshot snapshot) => snapshot.reference.delete(),
          ),
        );

    // delete like
    await _db
        .collection('likes')
        .where('likedPostId', isEqualTo: postId)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents.forEach(
            (DocumentSnapshot snapshot) => snapshot.reference.delete(),
          ),
        );

    // delete image
    await FirebaseStorage.instance.ref().child(imageStoragePath).delete();
  }
}
