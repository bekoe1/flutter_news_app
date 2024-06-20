import 'package:NewsApp/di/injection.dart';
import 'package:NewsApp/firebase_options.dart';
import 'package:NewsApp/presentation/auth_page/auth_page.dart';
import 'package:NewsApp/presentation/login_page/bloc/log_in_bloc.dart';
import 'package:NewsApp/presentation/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogInBloc>(
          create: (BuildContext context) => getIt<LogInBloc>(),
        ),
        BlocProvider<SignUpBloc>(
          create: (BuildContext context) => getIt<SignUpBloc>(),
        ),
      ],
      child: const MaterialApp(
        home: AuthPage(),
      ),
    );
  }
}
