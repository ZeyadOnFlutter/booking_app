import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeIndicator extends StatelessWidget {
  const SwipeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.swipe_rounded,
            color: const Color(0xFF3B82F6),
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'Swipe to change day',
            style: TextStyle(
              color: const Color(0xFF3B82F6),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.arrow_forward_rounded,
            color: const Color(0xFF3B82F6),
            size: 16.sp,
          ),
        ],
      ),
    );
  }
}
