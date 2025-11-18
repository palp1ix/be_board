part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpButtonPressed extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final File? avatar;

  const SignUpButtonPressed({
    required this.email,
    required this.password,
    required this.name,
    this.avatar,
  });

  @override
  List<Object?> get props => [email, password, name, avatar];
}

class SignOutButtonPressed extends AuthEvent {}

class PickImageButtonPressed extends AuthEvent {}
