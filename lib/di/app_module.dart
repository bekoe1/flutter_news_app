import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @singleton
  FirebaseAuth firebaseAuth() => FirebaseAuth.instance;
}
