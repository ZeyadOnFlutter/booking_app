import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/booking_entity.dart';
import '../cubit/session_cubit.dart';
import '../cubit/session_state.dart';
import 'session_item.dart';

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
                    return SessionItem(
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
