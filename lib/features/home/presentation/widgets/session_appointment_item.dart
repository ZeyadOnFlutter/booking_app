import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/session_helper.dart';
import '../../domain/entities/session_entity.dart';

class SessionAppointmentBuilder extends StatelessWidget {
  final SessionEntity session;

  const SessionAppointmentBuilder({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    final color = SessionHelpers.getSessionColor(session.type);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.8),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  SessionHelpers.getSessionIcon(session.type),
                  color: Colors.white,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    session.type,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.white.withOpacity(0.9),
                  size: 12.sp,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    '${SessionHelpers.formatTime(session.startTime)} - ${SessionHelpers.formatTime(session.endTime)}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
