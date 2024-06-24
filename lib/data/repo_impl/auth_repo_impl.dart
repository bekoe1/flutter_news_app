import 'package:NewsApp/domain/models/user_model.dart';
import 'package:NewsApp/domain/repositories/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _auth;

  AuthRepoImpl(this._auth);

  @override
  Future<String?> createUserWithEmailAndPass({
    required String email,
    required String pass,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      final response = await userCredential.user?.updateDisplayName(name);
      userCredential.user?.reload();
      return null;
    } on FirebaseAuthException catch (e) {
      return (e.message);
    }
  }

  @override
  Future<UserModel> logInWithEmailAndPass(
      {required String email, required String pass}) async {
    final response =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return UserModel(
        email: email,
        id: response.user!.uid,
        name: response.user!.displayName!);
  }

  @override
  void checkUsersDb() {
    // TODO: implement checkUsersDb
  }

  @override
  Future<void> isEmailInDb(String email) async {
    throw Exception("");
  }

  @override
  Future<void> sendPasswordResetLink({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserModel?> logInWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();
    if (googleAccount == null) {
      return null;
    }
    final googleAuth = await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userInfo =
        await _auth.signInWithCredential(credential);
    final user = userInfo.user;

    if (user != null) {
      return UserModel(
        email: user.email ?? "No email",
        id: user.uid,
        imageUrl: user.photoURL,
        name: user.displayName ?? "No displayed name",
      );
    } else {
      return null;
    }
  }
}
