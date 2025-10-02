import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionHelpers {
  SessionHelpers._();

  static Color getSessionColor(String type) {
    switch (type.toLowerCase()) {
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

  /// Returns the icon for a session type
  static IconData getSessionIcon(String type) {
    switch (type.toLowerCase()) {
      case 'circuit training':
        return Icons.loop_rounded;
      case 'yoga':
        return Icons.self_improvement_rounded;
      case 'endurance':
        return Icons.directions_run_rounded;
      case 'hiit':
        return Icons.whatshot_rounded;
      case 'pilates':
        return Icons.accessibility_new_rounded;
      default:
        return Icons.fitness_center_rounded;
    }
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  static bool canModifySession(DateTime sessionStartTime) {
    final now = DateTime.now();
    final difference = sessionStartTime.difference(now);
    return difference.inHours >= 2;
  }
}
