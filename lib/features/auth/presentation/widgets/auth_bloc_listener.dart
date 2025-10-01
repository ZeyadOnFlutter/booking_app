import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/ui_utils.dart';
import '../cubit/auth_hydrated_cubit.dart';
import '../cubit/auth_state.dart';

class AuthBlocListener extends StatelessWidget {
  final Widget child;
  final String routePath;
  const AuthBlocListener({super.key, required this.child, required this.routePath});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          UIUtils.showLoading(context);
        } else if (state is AuthError) {
          UIUtils.hideLoading(context);
          UIUtils.showMessage(state.message);
        } else if (state is Authenticated) {
          UIUtils.hideLoading(context);
          context.pushReplacementNamed(routePath);
        } else if (state is Unauthenticated) {
          UIUtils.hideLoading(context);
          context.pushReplacementNamed(routePath);
        }
      },
      child: child,
    );
  }
}
