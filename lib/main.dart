import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'core/app_bloc_observer.dart';
import 'core/router/app_router.dart';
import 'core/service/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubit/auth_hydrated_cubit.dart';
import 'features/home/presentation/cubit/booking_cubit.dart';
import 'features/home/presentation/cubit/session_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  final directory = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb ? HydratedStorageDirectory.web : HydratedStorageDirectory(directory.path),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const BookingApp()),
  );
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (context) => getIt<AuthCubit>(),
            ),
            BlocProvider<SessionCubit>(
              create: (context) => getIt<SessionCubit>(),
            ),
            BlocProvider<BookingCubit>(
              create: (context) => getIt<BookingCubit>(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Scrap',
            theme: appTheme,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
