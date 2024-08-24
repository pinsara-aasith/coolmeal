import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coolmeal/bloc/authentication_repository.dart';
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
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    
    _userSubscription = _authenticationRepository.user.listen(
      (user) { 
        print("User");
        print(user?.email);
        return add(_AppUserChanged(user));
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User?> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    print(event);
    emit(
      event.user != null
          ? AppState.authenticated(event.user!)
          : const AppState.unauthenticated(),
    );
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