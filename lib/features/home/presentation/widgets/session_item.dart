import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/session_helper.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'app_snack_bar.dart';

class SessionItem extends StatelessWidget {
  final SessionEntity session;
  final BookingEntity currentBooking;

  const SessionItem({
    required this.session,
    required this.currentBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      child: ListTile(
        title: Text(
          DateFormat('EEE, MMM d').format(session.startTime),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${SessionHelpers.formatTime(session.startTime)} - ${SessionHelpers.formatTime(session.endTime)}',
          style: TextStyle(fontSize: 12.sp),
        ),
        trailing: Text(
          '${session.capacity} spots',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.green,
          ),
        ),
        onTap: () => _showConfirmDialog(context),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Reschedule'),
        content: Text(
          'Move to ${DateFormat('MMM d').format(session.startTime)} at ${SessionHelpers.formatTime(session.startTime)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          BlocConsumer<BookingCubit, BookingState>(
            listener: (context, state) {
              if (state is UpdateBookingLoading) {
                UIUtils.showLoading(context);
              } else if (state is UpdateBookingError) {
                UIUtils.hideLoading(context);
                Navigator.pop(dialogContext);
                Navigator.pop(context);
                AppSnackBar.error(context, state.message);
              } else if (state is UpdateBookingSuccess) {
                UIUtils.hideLoading(context);
                Navigator.pop(dialogContext);
                Navigator.pop(context);
                AppSnackBar.success(context, 'Session rescheduled!');
              }
            },
            builder: (context, state) {
              return TextButton(
                onPressed: () => _confirmReschedule(context),
                child: const Text('Confirm'),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _confirmReschedule(BuildContext context) async {
    final updatedBooking = BookingEntity(
      id: currentBooking.id,
      userId: currentBooking.userId,
      sessionId: session.id,
      sessionType: session.type,
      sessionStartTime: session.startTime,
      sessionEndTime: session.endTime,
      bookingDate: currentBooking.bookingDate,
      status: currentBooking.status,
    );

    await context.read<BookingCubit>().updateBooking(
          updatedBooking,
          currentBooking.userId,
        );
  }
}
