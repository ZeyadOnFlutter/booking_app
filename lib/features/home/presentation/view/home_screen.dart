import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_indicator.dart';
import '../cubit/session_cubit.dart';
import '../cubit/session_state.dart';
import '../widgets/calendar_item.dart';
import '../widgets/error_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          if (state is SessionLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is SessionError) {
            return ErrorView(errorMessage: state.errorMessage);
          } else if (state is SessionSuccess) {
            return CalendarWidget(sessions: state.sessions);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
