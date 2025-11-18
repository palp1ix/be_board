part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileDataLoaded extends ProfileEvent {}

class ProfileSignOutButtonPressed extends ProfileEvent {}
