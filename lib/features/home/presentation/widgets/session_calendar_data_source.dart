import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../domain/entities/session_entity.dart';

class SessionCalendarDataSource extends CalendarDataSource {
  @override
  SessionCalendarDataSource(List<SessionEntity> sessions) {
    appointments = sessions;
  }
  @override
  DateTime getStartTime(int index) => appointments![index].startTime;
  @override
  DateTime getEndTime(int index) => appointments![index].endTime;
  @override
  String getSubject(int index) => appointments![index].type;
  @override
  @override
  Color getColor(int index) {
    final type = appointments![index].type.toLowerCase();

    switch (type) {
      case 'circuit training':
        return Colors.blue;
      case 'yoga':
        return Colors.green;
      case 'endurance':
        return Colors.orange;
      case 'hiit':
        return Colors.red;
      case 'pilates':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  bool isAllDay(int index) => false;
}
