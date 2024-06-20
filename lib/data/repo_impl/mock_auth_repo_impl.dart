import 'dart:developer';

import 'package:NewsApp/domain/models/user_model.dart';
import 'package:NewsApp/domain/repositories/auth/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepo)
class MockAuthRepoImpl implements AuthRepo {
  final Map<String, UserModel> usersDb = {
    '810710871': UserModel(
      email: 'qq@qq.qq',
      name: 'viktor',
      id: '810710871',
    ),
    '256806950': UserModel(
      email: 'ww@ww.ww',
      name: "fedor",
      id: '256806950',
    ),
  };

  String getUidFromEmailAndPass({required String email, required String pass}) {
    String combinedString = '$email-$pass';

    int hashCode = combinedString.hashCode;

    return hashCode.toString();
  }

  @override
  void checkUsersDb() {
    usersDb.forEach((key, value) {
      log('uid: $key, email: ${value.email}, name: ${value.name}');
    });
  }

  @override
  Future<String?> createUserWithEmailAndPass({
    required String email,
    required String pass,
    required String name,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    String uid = getUidFromEmailAndPass(
      email: email,
      pass: pass,
    );
    if (usersDb.containsKey(uid)) {
      throw "User already exists";
    } else {
      usersDb[uid] = UserModel(
        email: email,
        id: uid,
        name: name,
      );

      return null;
    }
  }

  @override
  Future<UserModel> logInWithEmailAndPass({
    required String email,
    required String pass,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final id = getUidFromEmailAndPass(
      email: email,
      pass: pass,
    );
    log(id);
    if (!usersDb.containsKey(id) || usersDb[id] == null) {
      throw ("User doesn't exist");
    } else {
      log(usersDb[id]!.name);
      return usersDb[id]!;
    }
  }
}
