import 'package:coolmeal/repositories/authentication_repository.dart';
import 'package:coolmeal/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_or_signup_state.dart';

class LoginOrSignupCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  LoginOrSignupCubit(this._authenticationRepository) : super(AuthInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> createAccountAndLinkItWithGoogleAccount(
      String email,
      String password,
      GoogleSignInAccount googleUser,
      OAuthCredential credential) async {
    emit(AuthLoading());

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: googleUser.email,
        password: password,
      );
      await _firebaseAuth.currentUser!.linkWithCredential(credential);
      await _firebaseAuth.currentUser!
          .updateDisplayName(googleUser.displayName);
      await _firebaseAuth.currentUser!.updatePhotoURL(googleUser.photoUrl);
      emit(UserSingupAndLinkedWithGoogle());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushNamed(context, Routes.signupScreen);
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _authenticationRepository.logInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user!.emailVerified) {
        emit(UserSignIn());
      } else {
        await _firebaseAuth.signOut();
        emit(AuthError('Email not verified. Please check your email.'));
        emit(UserNotVerified());
      }
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInResult r = await _authenticationRepository.logInWithGoogle();

    if (r.firebaseCredential.additionalUserInfo!.isNewUser) {
      await _firebaseAuth.currentUser!.delete();

      emit(IsNewUser(googleUser: r.googleUser, credential: r.oAuthCredential));
    } else {
      emit(UserSignIn());
    }
    emit(AuthLoading());
    try {} catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    await _firebaseAuth.signOut();
    emit(UserSignedOut());
  }

  Future<void> signUpWithEmail(
      String name, String email, String password) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firebaseAuth.currentUser!.updateDisplayName(name);
      await _firebaseAuth.currentUser!.sendEmailVerification();
      await _firebaseAuth.signOut();
      emit(UserSingupButNotVerified());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
