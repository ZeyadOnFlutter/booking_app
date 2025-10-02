import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service/service_locator.dart';
import '../../../auth/presentation/cubit/auth_hydrated_cubit.dart';

class CalendarHeader extends StatelessWidget {
  final int totalSessions;

  const CalendarHeader({
    super.key,
    required this.totalSessions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF6F767E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                getIt<AuthCubit>().currentUser?.name ?? 'Training Schedule',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1D1F),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            child: Image.asset(
              'assets/images/running.png',
              width: 40.w,
              height: 40.h,
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) {
      return 'Good Morning 👋';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon 👋';
    } else {
      return 'Good Evening 👋';
    }
  }
}
