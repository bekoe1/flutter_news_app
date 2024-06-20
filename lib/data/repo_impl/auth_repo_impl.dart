import 'package:NewsApp/domain/models/user_model.dart';
import 'package:NewsApp/domain/repositories/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}
