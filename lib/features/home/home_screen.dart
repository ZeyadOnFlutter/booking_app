import 'package:flutter/material.dart';

import '../../core/router/route_names.dart';
import '../../core/service/service_locator.dart';
import '../auth/presentation/cubit/auth_hydrated_cubit.dart';
import '../auth/presentation/widgets/auth_bloc_listener.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBlocListener(
        routePath: RouteNames.login,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              final authCubit = getIt<AuthCubit>();
              authCubit.logout();
            },
            child: const Text('Logout'),
          ),
        ),
      ),
    );
  }
}
