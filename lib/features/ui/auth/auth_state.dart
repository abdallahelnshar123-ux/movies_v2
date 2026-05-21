import 'package:movies/domain/entities/response/user/my_user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthLogoutLoading extends AuthState {}

class AuthLogoutError extends AuthState {
  final String message;

  AuthLogoutError(this.message);
}

class AuthLoginError extends AuthState {
  final String message;

  AuthLoginError(this.message);
}

class AuthRegisterLoading extends AuthState {}

class AuthRegisterError extends AuthState {
  final String message;

  AuthRegisterError(this.message);
}

class AuthContinueWithGoogleLoading extends AuthState {}

class AuthContinueWithGoogleError extends AuthState {
  final String message;

  AuthContinueWithGoogleError(this.message);
}

class AuthAuthenticated extends AuthState {
  final MyUser? currentUser;

  AuthAuthenticated(this.currentUser);
}

class AuthUnauthenticated extends AuthState {}

// todo: update states
class AuthUpdateLoading extends AuthState {}

class AuthUpdateSuccess extends AuthState {}

class AuthUpdateError extends AuthState {
  final String message;

  AuthUpdateError(this.message);
}

// todo: delete states

class AccountDeleteLoading extends AuthState {}

class AccountDeleteSuccess extends AuthState {}

class AccountDeleteError extends AuthState {
  final String message;

  AccountDeleteError(this.message);
}
