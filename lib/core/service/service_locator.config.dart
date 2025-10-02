// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:booking_app/core/service/register_module.dart' as _i261;
import 'package:booking_app/features/auth/data/data_source/firebase_data_source/firebase_auth_data_source.dart'
    as _i517;
import 'package:booking_app/features/auth/data/data_source/firebase_data_source/firebase_auth_data_source_impl.dart'
    as _i347;
import 'package:booking_app/features/auth/data/repository/auth_repository_impl.dart'
    as _i119;
import 'package:booking_app/features/auth/domain/repository/auth_repository.dart'
    as _i860;
import 'package:booking_app/features/auth/domain/use_case/facebook_sign_in_use_case.dart'
    as _i131;
import 'package:booking_app/features/auth/domain/use_case/google_sign_in_use_case.dart'
    as _i982;
import 'package:booking_app/features/auth/domain/use_case/login_use_case.dart'
    as _i1054;
import 'package:booking_app/features/auth/domain/use_case/logout_use_case.dart'
    as _i586;
import 'package:booking_app/features/auth/domain/use_case/register_use_case.dart'
    as _i939;
import 'package:booking_app/features/auth/presentation/cubit/auth_hydrated_cubit.dart'
    as _i713;
import 'package:booking_app/features/home/data/data_source/firebase_data_source/firebase_sessions_data_source.dart'
    as _i188;
import 'package:booking_app/features/home/data/data_source/firebase_data_source/firebase_sessions_data_source_impl.dart'
    as _i555;
import 'package:booking_app/features/home/data/repository/session_repository_impl.dart'
    as _i636;
import 'package:booking_app/features/home/domain/repository/session_repository.dart'
    as _i1007;
import 'package:booking_app/features/home/domain/use_case/add_booking_use_case.dart'
    as _i407;
import 'package:booking_app/features/home/domain/use_case/delete_booking_use_case.dart'
    as _i998;
import 'package:booking_app/features/home/domain/use_case/get_booking_use_case.dart'
    as _i1050;
import 'package:booking_app/features/home/domain/use_case/session_use_case.dart'
    as _i419;
import 'package:booking_app/features/home/presentation/cubit/booking_cubit.dart'
    as _i783;
import 'package:booking_app/features/home/presentation/cubit/session_cubit.dart'
    as _i577;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i188.FirebaseSessionsDataSource>(() =>
        _i555.FirebaseSessionsDataSourceImpl(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i517.FirebaseAuthDataSource>(
        () => _i347.FirebaseAuthDataSourceImpl(
              gh<_i59.FirebaseAuth>(),
              gh<_i974.FirebaseFirestore>(),
            ));
    gh.lazySingleton<_i860.AuthRepository>(
        () => _i119.AuthRepositoryImpl(gh<_i517.FirebaseAuthDataSource>()));
    gh.lazySingleton<_i1007.SessionRepository>(() =>
        _i636.SessionRepositoryImpl(gh<_i188.FirebaseSessionsDataSource>()));
    gh.lazySingleton<_i131.FacebookSignInUseCase>(
        () => _i131.FacebookSignInUseCase(gh<_i860.AuthRepository>()));
    gh.lazySingleton<_i982.GoogleSignInUseCase>(
        () => _i982.GoogleSignInUseCase(gh<_i860.AuthRepository>()));
    gh.lazySingleton<_i1054.LoginUseCase>(
        () => _i1054.LoginUseCase(gh<_i860.AuthRepository>()));
    gh.lazySingleton<_i586.LogoutUseCase>(
        () => _i586.LogoutUseCase(gh<_i860.AuthRepository>()));
    gh.lazySingleton<_i939.RegisterUseCase>(
        () => _i939.RegisterUseCase(gh<_i860.AuthRepository>()));
    gh.lazySingleton<_i407.AddBookingUseCase>(
        () => _i407.AddBookingUseCase(gh<_i1007.SessionRepository>()));
    gh.lazySingleton<_i998.DeleteBookingUseCase>(
        () => _i998.DeleteBookingUseCase(gh<_i1007.SessionRepository>()));
    gh.lazySingleton<_i1050.GetBookingUseCase>(
        () => _i1050.GetBookingUseCase(gh<_i1007.SessionRepository>()));
    gh.lazySingleton<_i419.SessionUseCase>(
        () => _i419.SessionUseCase(gh<_i1007.SessionRepository>()));
    gh.lazySingleton<_i783.BookingCubit>(() => _i783.BookingCubit(
          gh<_i407.AddBookingUseCase>(),
          gh<_i1050.GetBookingUseCase>(),
          gh<_i998.DeleteBookingUseCase>(),
        ));
    gh.lazySingleton<_i577.SessionCubit>(
        () => _i577.SessionCubit(gh<_i419.SessionUseCase>()));
    gh.singleton<_i713.AuthCubit>(() => _i713.AuthCubit(
          gh<_i131.FacebookSignInUseCase>(),
          gh<_i982.GoogleSignInUseCase>(),
          gh<_i1054.LoginUseCase>(),
          gh<_i939.RegisterUseCase>(),
          gh<_i586.LogoutUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i261.RegisterModule {}
