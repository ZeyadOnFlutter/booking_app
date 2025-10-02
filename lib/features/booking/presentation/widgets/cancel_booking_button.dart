import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/domain/entities/booking_entity.dart';
import '../../../home/presentation/widgets/cancel_booking.dart';

class CancelBookingButton extends StatelessWidget {
  final BookingEntity booking;

  const CancelBookingButton({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _handleCancel(context),
            icon: Icon(Icons.cancel_outlined, size: 18.sp),
            label: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFEF4444),
              side: const BorderSide(
                color: Color(0xFFEF4444),
                width: 1.5,
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleCancel(BuildContext context) {
    CancelBooking.handleCancel(context, booking, booking.sessionId);
  }
}
