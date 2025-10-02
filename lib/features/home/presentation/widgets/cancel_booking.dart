import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../domain/entities/booking_entity.dart';
import '../cubit/booking_cubit.dart';

class CancelBooking {
  static void handleCancel(BuildContext context, BookingEntity booking, String sessionId) {
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
            onPressed: () async {
              await context
                  .read<BookingCubit>()
                  .deleteBooking(booking.id, sessionId, booking.userId);

              if (context.mounted) {
                Navigator.pop(context);
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.success(
                    message: 'Booking Deleted Successfully',
                  ),
                  displayDuration: const Duration(seconds: 2),
                );
              }
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
