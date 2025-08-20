import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:project_iti_2025/data/repositories/auth_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButttonPressedEvent>(_onLogin);
  }

  static const String demoEmail = 'admin@gmail.com';
  static const String demoPassword = 'admin123';

  Future<void> _onLogin(
    LoginButttonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());

    if (event.email.isEmpty || event.password.isEmpty) {
      emit(LoginFaildState('Please enter both email and password.'));
      return;
    }

    if (event.email.trim() == demoEmail &&
        event.password.trim() == demoPassword) {
      emit(LoginRedirectToAdminState());
      return;
    }

    final authRepo = AuthRepo();

    try {
      final user = await authRepo.signInWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password.trim(),
      );

      if (user == null) {
        emit(LoginFaildState('Invalid email or password.'));
        return;
      }

      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFaildState('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFaildState('Incorrect password.'));
      } else if (e.code == 'user-disabled') {
        emit(LoginFaildState('This account has been disabled.'));
      } else {
        emit(LoginFaildState('Login failed: ${e.message}'));
      }
    } catch (e) {
      emit(LoginFaildState('error: ${e.toString()}'));
    }
  }
}
