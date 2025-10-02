import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancellationWarning extends StatelessWidget {
  const CancellationWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 16.sp,
            color: const Color(0xFFF59E0B),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Cancellation must be at least 2 hours before the session',
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFFF59E0B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
