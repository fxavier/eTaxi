import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etaxi/blocs/blocs.dart';
import 'package:etaxi/models/models.dart';
import 'package:etaxi/repositories/repositories.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState.unauthenticated()) {
    on<AppUserChanged>(_onAppUserChanged);
    on<AppLogoutRequested>(_onAppLogoutRequested);

    _userSubscription = _authRepository.user.listen(
      (user) => add(
        AppUserChanged(user),
      ),
    );
  }

  FutureOr<void> _onAppUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  FutureOr<void> _onAppLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
