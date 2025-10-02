import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/cubit/auth_hydrated_cubit.dart';
import '../../features/auth/presentation/cubit/auth_state.dart';
import '../../features/auth/presentation/view/login.dart';
import '../../features/auth/presentation/view/regsiter.dart';
import '../../features/booking/presentation/view/user_booking_screen.dart';
import '../../features/home/presentation/view/home_screen.dart';
import '../../features/onboarding/presentation/view/onboarding_screen.dart';
import 'route_names.dart';
import 'route_paths.dart';

final GoRouter router = GoRouter(
  initialLocation: RoutePaths.onboarding,
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final authCubit = context.read<AuthCubit>();
    final isAuthenticated = authCubit.state is Authenticated;

    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    final loggingIn = state.fullPath == RoutePaths.login;
    final registering = state.fullPath == RoutePaths.register;
    final onboarding = state.fullPath == RoutePaths.onboarding;

    // First time → force onboarding
    if (!hasSeenOnboarding && !onboarding) {
      return RoutePaths.onboarding;
    }

    // After seen → block onboarding
    if (hasSeenOnboarding && onboarding) {
      return isAuthenticated ? RoutePaths.home : RoutePaths.login;
    }

    // Not authenticated → block protected routes
    final protectedRoutes = [RoutePaths.home, RoutePaths.booking];
    if (!isAuthenticated && protectedRoutes.contains(state.fullPath)) {
      return RoutePaths.login;
    }

    // Authenticated → block login/register/onboarding
    if (isAuthenticated && (loggingIn || registering || onboarding)) {
      return RoutePaths.home;
    }

    return null;
  },
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
    GoRoute(
      path: RoutePaths.booking,
      name: RouteNames.booking,
      builder: (context, state) => const UserBookingsScreen(),
    ),
    GoRoute(
      path: RoutePaths.onboarding,
      name: RouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);
