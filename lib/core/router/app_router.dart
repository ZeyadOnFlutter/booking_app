import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/cubit/auth_hydrated_cubit.dart';
import '../../features/auth/presentation/cubit/auth_state.dart';
import '../../features/auth/presentation/view/login.dart';
import '../../features/auth/presentation/view/regsiter.dart';
import '../../features/home/presentation/view/home_screen.dart';
import 'route_names.dart';
import 'route_paths.dart';

final GoRouter router = GoRouter(
  initialLocation: RoutePaths.login,
  debugLogDiagnostics: true,
  // redirect: (context, state) {
  //   final authCubit = context.read<AuthCubit>();
  //   final isAuthenticated = authCubit.state is Authenticated;

  //   // if not logged in, always go to login
  //   if (!isAuthenticated && state.fullPath != RoutePaths.login) {
  //     return RoutePaths.login;
  //   }

  //   // if logged in and trying to go to login/register, send to home
  //   if (isAuthenticated &&
  //       (state.fullPath == RoutePaths.login || state.fullPath == RoutePaths.register)) {
  //     return RoutePaths.home;
  //   }

  //   return null;
  // },
  routes: [
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: RoutePaths.register,
      name: RouteNames.register,
      builder: (context, state) => const Register(),
    ),
    GoRoute(
      path: RoutePaths.home,
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
