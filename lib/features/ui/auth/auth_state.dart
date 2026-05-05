abstract class AuthState {}

class AuthInitial extends AuthState {}

// todo : login states
class AuthLoginLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthLoginError extends AuthState {
  final String message;

  AuthLoginError(this.message);
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

class AuthDeleteLoading extends AuthState {}

class AuthDeleteSuccess extends AuthState {}

class AuthDeleteError extends AuthState {
  final String message;

  AuthDeleteError(this.message);
}
