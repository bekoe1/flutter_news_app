import 'package:NewsApp/domain/models/user_model.dart';

abstract class AuthRepo {
  Future<String?> createUserWithEmailAndPass({
    required String email,
    required String pass,
    required String name,
  });

  Future<UserModel> logInWithEmailAndPass({
    required String email,
    required String pass,
  });
}
