import 'package:NewsApp/di/injection.dart';
import 'package:NewsApp/firebase_options.dart';
import 'package:NewsApp/presentation/auth_page/auth_page.dart';
import 'package:NewsApp/presentation/auth_page/bloc/auth_bloc.dart';
import 'package:NewsApp/presentation/reset_password_page/bloc/reset_password_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => getIt<AuthBloc>(),
        ),
        BlocProvider<ResetPasswordBloc>(
          create: (BuildContext context) => getIt<ResetPasswordBloc>(),
        ),
      ],
      child: const ScreenUtilInit(
        designSize: Size(393, 808),
        minTextAdapt: true,
        child: MaterialApp(
          home: AuthPage(),
        ),
      ),
    );
  }
}
