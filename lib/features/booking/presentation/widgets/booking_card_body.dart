import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/session_helper.dart';
import '../../../home/domain/entities/booking_entity.dart';
import 'booking_card_info.dart';
import 'cancel_booking_button.dart';
import 'cancellation_warning.dart';

class BookingCardBody extends StatelessWidget {
  final BookingEntity booking;
  final bool isUpcoming;
  final bool canCancel;

  const BookingCardBody({
    super.key,
    required this.booking,
    required this.isUpcoming,
    required this.canCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          BookingInfoRow(
            icon: Icons.access_time_rounded,
            label: 'Time',
            value:
                '${SessionHelpers.formatTime(booking.sessionStartTime)} - ${SessionHelpers.formatTime(booking.sessionEndTime)}',
          ),
          SizedBox(height: 12.h),
          BookingInfoRow(
            icon: Icons.event_available_rounded,
            label: 'Booked on',
            value: DateFormat('MMM d, y').format(booking.bookingDate),
          ),
          SizedBox(height: 12.h),
          BookingInfoRow(
            icon: Icons.info_outline_rounded,
            label: 'Status',
            value: isUpcoming ? 'Upcoming' : 'In Progress',
            statusColor: isUpcoming ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
          ),
          if (isUpcoming && canCancel) ...[
            SizedBox(height: 16.h),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
            SizedBox(height: 16.h),
            CancelBookingButton(booking: booking),
          ] else if (isUpcoming && !canCancel) ...[
            SizedBox(height: 12.h),
            const CancellationWarning(),
          ],
        ],
      ),
    );
  }
}
