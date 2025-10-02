import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyBookingsState extends StatelessWidget {
  const EmptyBookingsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.event_busy_rounded,
              size: 80.sp,
              color: const Color(0xFF3B82F6).withOpacity(0.5),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Active Bookings',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1D1F),
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              'You haven\'t booked any sessions yet.\nBrowse available sessions to get started!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6F767E),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
