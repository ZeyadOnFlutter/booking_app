import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/session_helper.dart';

class TodayBadge extends StatelessWidget {
  const TodayBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final color = SessionHelpers.getSessionColor('');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'TODAY',
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
