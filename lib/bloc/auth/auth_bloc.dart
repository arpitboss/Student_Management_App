import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      final user = _authService.auth.currentUser;
      if (user != null && user.emailVerified) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<AuthSignInRequested>((event, emit) async {
      emit(AuthLoading());
      final user = await _authService.signIn(event.email, event.password);
      if (user != null && user.emailVerified) {
        emit(AuthAuthenticated(user));
      } else if (user != null) {
        emit(AuthEmailVerification());
      } else {
        emit(const AuthError('Sign In Failed'));
      }
    });

    on<AuthSignUpRequested>((event, emit) async {
      emit(AuthLoading());
      final user = await _authService.signUp(event.email, event.password);
      if (user != null) {
        emit(AuthEmailVerification());
      } else {
        emit(const AuthError('Sign Up Failed'));
      }
    });

    on<AuthSignOutRequested>((event, emit) async {
      await _authService.signOut();
      emit(AuthUnauthenticated());
    });
  }
}
