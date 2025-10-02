import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../auth/presentation/cubit/auth_hydrated_cubit.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      title: Text(
        'Logout',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1A1D1F),
        ),
      ),
      content: Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFF6F767E),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6F767E),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<AuthCubit>().logout();
            context.pushReplacementNamed(RouteNames.login);
          },
          child: Text(
            'Logout',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFEF4444),
            ),
          ),
        ),
      ],
    );
  }
}
