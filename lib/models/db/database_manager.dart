import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// data models
import 'package:insta_clone/data_models/comment.dart';
import 'package:insta_clone/data_models/like.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/data_models/post.dart';

// database paths
const USERS = 'users';
const POSTS = 'posts';
const COMMENTS = 'comments';
const LIKES = 'likes';
const FOLLOWERS = 'followers';
const FOLLOWINGS = 'followings';

// database fields
const USER_ID = 'userId';
const POST_ID = 'postId';
const POST_DATE_TIME = 'postDateTime';
const COMMENT_DATE_TIME = 'commentDateTime';
const LIKE_USER_ID = 'likeUserId';
const LIKED_POST_ID = 'likedPostId';
const LIKE_DATE_TIME = 'likeDateTime';
const IN_APP_USER_NAME = 'inAppUserName';

class DatabaseManager {
  final Firestore _db = Firestore.instance;

  Future<bool> searchUserInDB(FirebaseUser firebaseUser) async {
    final query = await _db
        .collection(USERS)
        .where(USER_ID, isEqualTo: firebaseUser.uid)
        .getDocuments();
    return query.documents.length > 0;
  }

  Future<void> insertUser(User user) async {
    // toMapを用いてユーザー情報をDBで登録する形へ自動変換
    await _db.collection(USERS).document(user.userId).setData(user.toMap());
  }

  Future<User> getUserInfoFromDbById(String userId) async {
    final query = await _db
        .collection(USERS)
        .where(USER_ID, isEqualTo: userId)
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
    await _db.collection(POSTS).document(post.postId).setData(post.toMap());
  }

  Future<List<Post>> getMyselfAndFollowingUsersPosts(String myUserId) async {
    final query = await _db.collection(POSTS).getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    List<String> userIds = await getFollowingUserIds(myUserId);
    userIds.add(myUserId);

    return await _db
        .collection(POSTS)
        .where(USER_ID, whereIn: userIds)
        .orderBy(POST_DATE_TIME, descending: true)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map((DocumentSnapshot snapshot) => Post.fromMap(snapshot.data))
              .toList(),
        );
  }

  Future<List<Post>> getProfileUserPosts(String profileUserId) async {
    final query = await _db.collection(POSTS).getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    return await _db
        .collection(POSTS)
        .where(USER_ID, isEqualTo: profileUserId)
        .orderBy(POST_DATE_TIME, descending: true)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map((DocumentSnapshot snapshot) => Post.fromMap(snapshot.data))
              .toList(),
        );
  }

  Future<List<String>> getFollowerUserIds(String userId) async {
    final query = await _db
        .collection(USERS)
        .document(userId)
        .collection(FOLLOWERS)
        .getDocuments();

    return query.documents.length == 0
        ? []
        : query.documents
            .map(
              (DocumentSnapshot snapshot) => User.fromMap(snapshot.data).userId,
            )
            .toList();
  }

  Future<List<String>> getFollowingUserIds(String userId) async {
    final query = await _db
        .collection(USERS)
        .document(userId)
        .collection(FOLLOWINGS)
        .getDocuments();

    return query.documents.length == 0
        ? []
        : query.documents
            .map(
              (DocumentSnapshot snapshot) => User.fromMap(snapshot.data).userId,
            )
            .toList();
  }

  Future<void> updatePost(Post updatedPost) async {
    final DocumentReference reference =
        _db.collection(POSTS).document(updatedPost.postId);
    await reference.updateData(updatedPost.toMap());
  }

  Future<void> postComment(Comment comment) async {
    await _db
        .collection(COMMENTS)
        .document(comment.commentId)
        .setData(comment.toMap());
  }

  Future<List<Comment>> getComments(String postId) async {
    final query = await _db.collection(COMMENTS).getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    return await _db
        .collection(COMMENTS)
        .where(POST_ID, isEqualTo: postId)
        .orderBy(COMMENT_DATE_TIME)
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
    final reference = _db.collection(COMMENTS).document(deleteCommentId);
    await reference.delete();
  }

  Future<void> likeIt(Like like) async {
    await _db.collection(LIKES).document(like.likeId).setData(like.toMap());
  }

  Future<void> unLikeIt(Post post, User currentUser) async {
    await _db
        .collection(LIKES)
        .where(LIKED_POST_ID, isEqualTo: post.postId)
        .where(LIKE_USER_ID, isEqualTo: currentUser.userId)
        .getDocuments()
        .then(
          (QuerySnapshot snapshot) =>
              snapshot.documents.first.reference.delete(),
        );
  }

  Future<List<Like>> getLikeResult(String likedPostId) async {
    final query = await _db.collection(LIKES).getDocuments();
    if (query.documents.length == 0) {
      return [];
    }

    return await _db
        .collection(LIKES)
        .where(LIKED_POST_ID, isEqualTo: likedPostId)
        .orderBy(LIKE_DATE_TIME)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map((DocumentSnapshot snapshot) => Like.fromMap(snapshot.data))
              .toList(),
        );
  }

  Future<void> deletePost(String postId, String imageStoragePath) async {
    // delete post
    await _db.collection(POSTS).document(postId).delete();

    // delete comment
    await _db
        .collection(COMMENTS)
        .where(POST_ID, isEqualTo: postId)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents.forEach(
            (DocumentSnapshot snapshot) => snapshot.reference.delete(),
          ),
        );

    // delete like
    await _db
        .collection(LIKES)
        .where(LIKED_POST_ID, isEqualTo: postId)
        .getDocuments()
        .then(
          (QuerySnapshot querySnapshot) => querySnapshot.documents.forEach(
            (DocumentSnapshot snapshot) => snapshot.reference.delete(),
          ),
        );

    // delete image
    await FirebaseStorage.instance.ref().child(imageStoragePath).delete();
  }

  Future<void> updateProfile(User updatedUser) async {
    final DocumentReference reference =
        _db.collection(USERS).document(updatedUser.userId);
    await reference.updateData(updatedUser.toMap());
  }

  Future<List<User>> searchUsers(String queryString, User currentUser) async {
    final query = await _db
        .collection(USERS)
        .orderBy(IN_APP_USER_NAME)
        .startAt([queryString]).endAt([queryString + '\uf8ff']).getDocuments();
    // Firebaseの範囲クエリを使用
    // https://firebase.google.com/docs/database/rest/retrieve-data?hl=ja#range-queries

    return query.documents.length == 0
        ? []
        : query.documents
            .where(
              // 自身のユーザー情報を除去
              (DocumentSnapshot snapshot) =>
                  User.fromMap(snapshot.data).userId != currentUser.userId,
            )
            .map((DocumentSnapshot snapshot) => User.fromMap(snapshot.data))
            .toList();
  }

  Future<void> follow(User profileUser, User currentUser) async {
    await _db
        .collection(USERS)
        .document(currentUser.userId)
        .collection(FOLLOWINGS)
        .document(profileUser.userId)
        .setData({USER_ID: profileUser.userId});
    await _db
        .collection(USERS)
        .document(profileUser.userId)
        .collection(FOLLOWERS)
        .document(currentUser.userId)
        .setData({USER_ID: currentUser.userId});
  }

  Future<void> unFollow(User profileUser, User currentUser) async {
    await _db
        .collection(USERS)
        .document(currentUser.userId)
        .collection(FOLLOWINGS)
        .document(profileUser.userId)
        .delete();
    await _db
        .collection(USERS)
        .document(profileUser.userId)
        .collection(FOLLOWERS)
        .document(currentUser.userId)
        .delete();
  }

  Future<bool> checkIsFollowing(User profileUser, User currentUser) async {
    final query = await _db
        .collection(USERS)
        .document(currentUser.userId)
        .collection(FOLLOWINGS)
        .where(USER_ID, isEqualTo: profileUser.userId)
        .getDocuments();
    return query.documents.length > 0;
  }

  Future<List<String>> getLikeMeUserIds(String postId) async {
    final query = await _db
        .collection(LIKES)
        .where(LIKED_POST_ID, isEqualTo: postId)
        .getDocuments();
    return query.documents.length == 0
        ? []
        : query.documents
            .map(
              (DocumentSnapshot snapshot) =>
                  Like.fromMap(snapshot.data).likeUserId,
            )
            .toList();
  }

  Future<List<User>> getUsersById(List<String> userIds) async {
    return userIds.length == 0
        ? []
        : Future.wait(
            userIds.map(
              (userId) => getUserInfoFromDbById(userId),
            ),
          );

    // ~ NG CODE ~
    // E/flutter (27479): [ERROR:flutter/lib/ui/ui_dart_state.cc(157)]
    // Unhandled Exception: type 'List<Future<User>>' is not a subtype of
    // type 'FutureOr<List<User>>'
    //
    // return userIds.length == 0
    //     ? []
    //     : userIds
    //         .map((userId) => getUserInfoFromDbById(userId))
    //         .toList();
  }
}
