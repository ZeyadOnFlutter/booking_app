import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/service/service_locator.dart';
import '../cubit/auth_hydrated_cubit.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/register_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();
  final _nameNode = FocusNode();
  final _phoneController = TextEditingController();
  final _phoneNode = FocusNode();
  final _emailController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordNode = FocusNode();
  final _confirmPasswordController = TextEditingController();
  final _confirmPasswordNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  late final StreamSubscription<bool> keyboardSubscription;

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
    _nameController.dispose();
    _nameNode.dispose();
    _phoneController.dispose();
    _phoneNode.dispose();
    _emailController.dispose();
    _emailNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordNode.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: AuthBlocListener(
            routePath: RouteNames.login,
            child: RegisterForm(
              formKey: _formKey,
              nameController: _nameController,
              nameNode: _nameNode,
              phoneController: _phoneController,
              phoneNode: _phoneNode,
              emailController: _emailController,
              emailNode: _emailNode,
              passwordController: _passwordController,
              passwordNode: _passwordNode,
              confirmPasswordController: _confirmPasswordController,
              confirmPasswordNode: _confirmPasswordNode,
              onRegisterPressed: _onRegisterPressed,
              onLoginPressed: _onLoginPressed,
            ),
          ),
        ),
      ),
    );
  }

  void _onRegisterPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      final authCubit = getIt<AuthCubit>();
      authCubit.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneController.text,
      );
    }
  }

  void _onLoginPressed() {
    context.goNamed(RouteNames.login);
  }
}
