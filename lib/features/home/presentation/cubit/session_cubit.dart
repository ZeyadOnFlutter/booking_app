import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/session_entity.dart';
import '../../domain/use_case/session_use_case.dart';
import 'session_state.dart';

@lazySingleton
class SessionCubit extends Cubit<SessionState> {
  SessionCubit(
    this._sessionUseCase,
  ) : super(SessionInitial());
  final SessionUseCase _sessionUseCase;
  List<SessionEntity>? mySessions;
  Future<void> getSessions() async {
    emit(SessionLoading());
    final response = await _sessionUseCase();
    response.fold((failure) => emit(SessionError(failure.message)), (sessions) {
      mySessions = sessions;
      emit(SessionSuccess(sessions));
    });
  }
}
