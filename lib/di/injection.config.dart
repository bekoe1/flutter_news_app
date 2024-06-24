// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:NewsApp/data/repo_impl/auth_repo_impl.dart' as _i5;
import 'package:NewsApp/di/app_module.dart' as _i8;
import 'package:NewsApp/domain/repositories/auth/auth_repo.dart' as _i4;
import 'package:NewsApp/presentation/auth_page/bloc/auth_bloc.dart' as _i6;
import 'package:NewsApp/presentation/reset_password_page/bloc/reset_password_bloc.dart'
    as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.FirebaseAuth>(() => appModule.firebaseAuth());
    gh.singleton<_i4.AuthRepo>(() => _i5.AuthRepoImpl(gh<_i3.FirebaseAuth>()));
    gh.factory<_i6.AuthBloc>(() => _i6.AuthBloc(gh<_i4.AuthRepo>()));
    gh.factory<_i7.ResetPasswordBloc>(
        () => _i7.ResetPasswordBloc(gh<_i4.AuthRepo>()));
    return this;
  }
}

class _$AppModule extends _i8.AppModule {}
