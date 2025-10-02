import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/session_helper.dart';
import '../../../home/domain/entities/booking_entity.dart';
import 'booking_card_body.dart';
import 'booking_card_header.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final color = SessionHelpers.getSessionColor(booking.sessionType);
    final now = DateTime.now();
    final isUpcoming = booking.sessionStartTime.isAfter(now);
    final isToday = _isToday(booking.sessionStartTime);
    final canCancel = SessionHelpers.canModifySession(booking.sessionStartTime);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          BookingCardHeader(
            booking: booking,
            color: color,
            isToday: isToday,
          ),
          BookingCardBody(
            booking: booking,
            isUpcoming: isUpcoming,
            canCancel: canCancel,
          ),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}
