part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginCheekinState extends LoginState {
  final String email;
  LoginCheekinState(this.email);
}

class LoginSuccessState extends LoginState {}

class LoginFaildState extends LoginState {
  final String msg;
  LoginFaildState(this.msg);
}

class LoginNotVilad extends LoginState {}

class LoginRedirectToAdminState extends LoginState {}
