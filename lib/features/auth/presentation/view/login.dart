import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/service/service_locator.dart';
import '../cubit/auth_hydrated_cubit.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/login_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  late StreamSubscription<bool> keyboardSubscription;
  @override
  void initState() {
    super.initState();
    final keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen(
      (bool visible) {
        if (!visible) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AuthBlocListener(
          routePath: RouteNames.home,
          child: LoginForm(
            formKey: _formKey,
            emailController: _emailController,
            emailNode: _emailNode,
            passwordController: _passwordController,
            passwordNode: _passwordNode,
            onLoginPressed: _onLoginPressed,
            onRegisterPressed: _onRegisterPressed,
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() {
    // if (_formKey.currentState?.validate() ?? false) {
    //   final authcubit = getIt<AuthCubit>();
    //   authcubit.login(_emailController.text, _passwordController.text);
    // }
  }

  void _onRegisterPressed() {
    if (mounted) {
      context.pushReplacementNamed(RouteNames.register);
    }
  }
}
