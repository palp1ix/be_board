part of 'profile_bloc.dart';


abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final String name;
  final String email;
  final String? avatarUrl;

  const ProfileLoadSuccess({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [name, email, avatarUrl];
}

class ProfileLoadFailure extends ProfileState {
  final String message;

  const ProfileLoadFailure(this.message);

    @override
  List<Object> get props => [message];
}
