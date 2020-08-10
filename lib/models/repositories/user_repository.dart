import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// data models
import 'package:insta_clone/data_models/user.dart';

// models
import 'package:insta_clone/models/db/database_manager.dart';

class UserRepository {
  final DatabaseManager dbManager;
  UserRepository({this.dbManager});

  static User currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> isSignIn() async {
    final FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      currentUser = await dbManager.getUserInfoFromDbById(user.uid);
      return true;
    }
    return false;
  }

  Future<bool> signIn() async {
    try {
      // Googleにログイン
      final GoogleSignInAccount signInAccount = await _googleSignIn.signIn();

      // 認証情報(Authentication)を取得
      final GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;

      // Firebase認証に必要な信用状(Credential)を取得
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken,
      );

      // ユーザー情報(FirebaseUser)を取得
      final FirebaseUser firebaseUser =
          (await _auth.signInWithCredential(credential)).user;

      if (firebaseUser == null) {
        return false;
      }

      final isUserExistedInDB = await dbManager.searchUserInDB(firebaseUser);
      if (!isUserExistedInDB) {
        // DBにユーザーが存在しない場合、ユーザーを生成する
        await dbManager.insertUser(_convertToUser(firebaseUser));
      }

      // アプリ全体で使用可能とするためにstatic変数に格納する
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);

      return true;
    } catch (e) {
      print('sign in error caught: ${e.toString()}');
      return false;
    }
  }

  _convertToUser(FirebaseUser firebaseUser) {
    // Firebaseのユーザー情報をアプリ内で使用するユーザー情報に変換
    return User(
      userId: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      inAppUserName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoUrl,
      email: firebaseUser.email,
      bio: '',
    );
  }

  Future<User> getUserById(String userId) async =>
      await dbManager.getUserInfoFromDbById(userId);
}
