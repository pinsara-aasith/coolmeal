import 'package:bloc/bloc.dart';
import 'package:coolmeal/models/user_profile.dart';
import 'package:coolmeal/repositories/user_profile_repository.dart';
import 'package:equatable/equatable.dart';


class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository userProfileRepository;

  UserProfileBloc({required this.userProfileRepository}) : super(UserProfileInitial()) {
    on<SaveUserProfile>(_onSaveUserProfile);
    on<LoadUserProfile>(_onLoadUserProfile);
  }

  void _onSaveUserProfile(SaveUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileSaving());
    try {
      await userProfileRepository.saveUserProfile(event.userProfile);
      emit(UserProfileSaved());
    } catch (e) {
      emit(const UserProfileError('Failed to save profile'));
    }
  }

  void _onLoadUserProfile(LoadUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      final profile = await userProfileRepository.loadUserProfile(event.email);
      if (profile != null) {
        emit(UserProfileLoaded(profile));
      } else {
        emit(const UserProfileError('Profile not found'));
      }
    } catch (e) {
      emit(const UserProfileError('Failed to load profile'));
    }
  }
}

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class SaveUserProfile extends UserProfileEvent {
  final UserProfile userProfile;

  const SaveUserProfile(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class LoadUserProfile extends UserProfileEvent {
  final String email;

  const LoadUserProfile(this.email);

  @override
  List<Object> get props => [email];
}

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class UserProfileSaving extends UserProfileState {}

class UserProfileSaved extends UserProfileState {}

class UserProfileError extends UserProfileState {
  final String message;

  const UserProfileError(this.message);

  @override
  List<Object> get props => [message];
}

