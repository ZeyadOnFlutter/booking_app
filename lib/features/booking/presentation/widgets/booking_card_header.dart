import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/session_helper.dart';
import '../../../home/domain/entities/booking_entity.dart';
import 'today_badge.dart';

class BookingCardHeader extends StatelessWidget {
  final BookingEntity booking;
  final Color color;
  final bool isToday;

  const BookingCardHeader({
    super.key,
    required this.booking,
    required this.color,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.8),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              SessionHelpers.getSessionIcon(booking.sessionType),
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.sessionType,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 12.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      DateFormat('EEE, MMM d').format(booking.sessionStartTime),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isToday) const TodayBadge(),
        ],
      ),
    );
  }
}
