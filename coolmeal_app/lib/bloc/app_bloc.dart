import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coolmeal/repositories/authentication_repository.dart';
import 'package:coolmeal/models/user.dart';
import 'package:equatable/equatable.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser != null
              ? AppState.authenticated(authenticationRepository.currentUser!)
              : const AppState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserLoginStatusChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    _userSubscription = _authenticationRepository.user.listen(
      (user) {
        print(user?.email);
        return add(_AppUserChanged(user));
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User?> _userSubscription;

  void _onUserLoginStatusChanged(
      _AppUserChanged event, Emitter<AppState> emit) {
    if (event.user != null && event.user!.emailVerified) {
      emit(AppState.authenticated(event.user!));
    } else if (event.user != null && !event.user!.emailVerified) {
      emit(AppState.authenticatedNotVerified(event.user!));
    }  else if (event.user == null) {
      emit(const AppState.unauthenticated());
    } 
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

enum AppStatus {
  authenticated,
  authenticatedNotVerified,
  unauthenticated,
  unknown
}

final class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user,
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.authenticatedNotVerified(User user)
      : this._(status: AppStatus.authenticatedNotVerified, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User? user;

  @override
  List<Object> get props => [status, user ?? ''];
}

sealed class AppEvent {
  const AppEvent();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final User? user;
}
