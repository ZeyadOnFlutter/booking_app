import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../domain/entities/session_entity.dart';
import 'app_snack_bar.dart';
import 'calendar_header.dart';
import 'session_appointment_item.dart';
import 'session_calendar_data_source.dart';
import 'session_details_bottom_sheet.dart';
import 'session_status_card.dart';
import 'swipe_indicator.dart';

class CalendarWidget extends StatelessWidget {
  final List<SessionEntity> sessions;

  const CalendarWidget({
    super.key,
    required this.sessions,
  });

  @override
  Widget build(BuildContext context) {
    final dataSource = SessionCalendarDataSource(sessions);
    final todaySessions = _getTodaySessions();

    return SafeArea(
      child: Column(
        children: [
          CalendarHeader(totalSessions: sessions.length),
          SizedBox(height: 16.h),
          SessionStatsCard(
            todaySessionsCount: todaySessions.length,
            totalSessionsCount: sessions.length,
          ),
          const CalendarInstructions(),
          SizedBox(height: 16.h),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: SfCalendar(
                  initialDisplayDate: DateTime.now(),
                  minDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                  maxDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day + 7,
                  ),
                  view: CalendarView.day,
                  dataSource: dataSource,
                  headerStyle: CalendarHeaderStyle(
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1D1F),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  viewHeaderStyle: ViewHeaderStyle(
                    dayTextStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1D1F),
                    ),
                    dateTextStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1D1F),
                    ),
                  ),
                  timeSlotViewSettings: TimeSlotViewSettings(
                    startHour: 7,
                    endHour: 23,
                    timeIntervalHeight: 80.h,
                    timeFormat: 'h:mm a',
                    timeTextStyle: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF6F767E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  todayHighlightColor: const Color(0xFF3B82F6),
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color(0xFF3B82F6),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  appointmentBuilder: (context, details) {
                    final SessionEntity session = details.appointments.first as SessionEntity;
                    return SessionAppointmentBuilder(session: session);
                  },
                  onTap: (CalendarTapDetails details) {
                    if (details.appointments != null && details.appointments!.isNotEmpty) {
                      final SessionEntity session = details.appointments!.first as SessionEntity;
                      final currentTime = DateTime.now();
                      if (currentTime.isAfter(session.endTime)) {
                        AppSnackBar.error(context, 'Session Already Ended');
                      } else if (currentTime.isAfter(session.startTime)) {
                        AppSnackBar.error(context, 'Session ALready Started');
                      } else {
                        showSessionDetailsBottomSheet(context, session);
                      }
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  List<SessionEntity> _getTodaySessions() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    return sessions.where((session) {
      return session.startTime.isAfter(today) && session.startTime.isBefore(tomorrow);
    }).toList();
  }
}
