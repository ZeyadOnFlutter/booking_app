// ============================================================================
// FILE: reschedule_bottom_sheet.dart - SIMPLE IMPLEMENTATION
// ============================================================================

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
import '../cubit/session_cubit.dart';
import '../cubit/session_state.dart';
import 'app_snack_bar.dart';

void showRescheduleBottomSheet(
  BuildContext context,
  BookingEntity currentBooking,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => RescheduleBottomSheet(
      currentBooking: currentBooking,
    ),
  );
}

class RescheduleBottomSheet extends StatelessWidget {
  final BookingEntity currentBooking;

  const RescheduleBottomSheet({
    super.key,
    required this.currentBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reschedule ${currentBooking.sessionType}',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Select a new time slot',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<SessionCubit, SessionState>(
            builder: (context, state) {
              if (state is SessionLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final sessionCubit = context.read<SessionCubit>();
              final availableSessions = sessionCubit.mySessions!
                  .where(
                    (s) =>
                        s.type == currentBooking.sessionType &&
                        s.id != currentBooking.sessionId &&
                        s.capacity > 0 &&
                        s.startTime.isAfter(DateTime.now()),
                  )
                  .toList();

              availableSessions.sort((a, b) => a.startTime.compareTo(b.startTime));

              if (availableSessions.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: Text(
                      'No available sessions',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 300.h,
                child: ListView.builder(
                  itemCount: availableSessions.length,
                  itemBuilder: (context, index) {
                    final session = availableSessions[index];
                    return _SessionItem(
                      session: session,
                      currentBooking: currentBooking,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SessionItem extends StatelessWidget {
  final SessionEntity session;
  final BookingEntity currentBooking;

  const _SessionItem({
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

// ============================================================================
// FILE: Update session_details_bottom_sheet.dart
// Replace the _handleReschedule method with this:
// ============================================================================

/*
void _handleReschedule(BuildContext context, BookingEntity booking) {
  Navigator.pop(context);
  showRescheduleBottomSheet(context, booking);
}

// Don't forget to add this import at the top:
import 'reschedule_bottom_sheet.dart';
*/
