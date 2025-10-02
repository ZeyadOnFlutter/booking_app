import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/service/service_locator.dart';
import '../../../../core/utils/session_helper.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../auth/presentation/cubit/auth_hydrated_cubit.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';

void showSessionDetailsBottomSheet(BuildContext context, SessionEntity session) {
  final color = SessionHelpers.getSessionColor(session.type);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SessionDetailsBottomSheet(
      session: session,
      color: color,
    ),
  );
}

class SessionDetailsBottomSheet extends StatelessWidget {
  final SessionEntity session;
  final Color color;

  const SessionDetailsBottomSheet({
    super.key,
    required this.session,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    SessionHelpers.getSessionIcon(session.type),
                    color: color,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.type,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1D1F),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${SessionHelpers.formatTime(session.startTime)} - ${SessionHelpers.formatTime(session.endTime)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF6F767E),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Capacity: ${session.capacity} spots left',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: session.capacity > 0
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            BlocConsumer<BookingCubit, BookingState>(
              listener: (context, state) {
                if (state is AddBookingLoading || state is DeleteBookingLoading) {
                  UIUtils.showLoading(context);
                } else if (state is AddBookingError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is DeleteBookingError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is AddBookingSuccess) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage('Booking created successfully');
                  Navigator.pop(context);
                } else if (state is DeleteBookingSuccess) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage('Booking deleted successfully');
                  Navigator.pop(context); // optional: depends if you want to pop after delete
                }
              },
              builder: (context, state) {
                final bookingCubit = context.read<BookingCubit>();
                final existingBooking = bookingCubit.getBookingForSession(session.id);
                print(existingBooking?.sessionId ?? '');
                if (existingBooking != null) {
                  return Column(
                    children: [
                      // Cancel button
                      ElevatedButton(
                        onPressed: () {
                          _handleCancel(context, existingBooking);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Center(
                          child: Text(
                            'Cancel Booking',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Reschedule button
                      ElevatedButton(
                        onPressed: () {
                          _handleReschedule(context, existingBooking);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Center(
                          child: Text(
                            'Reschedule Session',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return ElevatedButton(
                  onPressed: () {
                    _addBooking(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Center(
                    child: Text(
                      'Book Session',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Future<void> _addBooking(BuildContext context) async {
    if (session.capacity <= 0) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'This session is full!',
        ),
        displayDuration: const Duration(seconds: 2),
      );
    } else if (session.startTime.difference(DateTime.now()).inMinutes < 15) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'You can only book at least 15 minutes before the session.',
        ),
        displayDuration: const Duration(seconds: 2),
      );
    } else {
      await _handleBookSession(context);
    }
  }

  Future<void> _handleBookSession(BuildContext context) async {
    final booking = BookingEntity(
      userId: context.read<AuthCubit>().currentUser?.id ?? '',
      sessionId: session.id,
      sessionType: session.type,
      sessionStartTime: session.startTime,
      sessionEndTime: session.endTime,
      bookingDate: DateTime.now(),
      status: 'active',
    );

    await context.read<BookingCubit>().addBooking(booking, session.id);
  }

  void _handleReschedule(BuildContext context, BookingEntity booking) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reschedule feature coming soon!'),
        backgroundColor: Color(0xFF3B82F6),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleCancel(BuildContext context, BookingEntity booking) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking cancelled successfully'),
                  backgroundColor: Color(0xFF10B981),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}
