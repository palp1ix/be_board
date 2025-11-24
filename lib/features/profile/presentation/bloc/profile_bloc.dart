import 'package:be_board/core/core.dart';
import 'package:be_board/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:be_board/features/profile/domain/usecases/get_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile _getProfile;
  final SignOutUseCase _signOutUseCase;

  ProfileBloc({
    required GetProfile getProfile,
    required SignOutUseCase signOutUseCase,
  }) : _getProfile = getProfile,
       _signOutUseCase = signOutUseCase,
       super(ProfileInitial()) {
    on<ProfileDataLoaded>(_onProfileDataLoaded);
    on<ProfileSignOutButtonPressed>(_onProfileSignOutButtonPressed);
  }

  Future<void> _onProfileDataLoaded(
    ProfileDataLoaded event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadInProgress());
    try {
      final profile = await _getProfile();
      emit(
        ProfileLoadSuccess(
          name: profile.name,
          email: profile.email,
          avatarUrl: profile.avatarUrl,
        ),
      );
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }

  Future<void> _onProfileSignOutButtonPressed(
    ProfileSignOutButtonPressed event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await _signOutUseCase();
      // Don't emit any state here - the GoRouter redirect will handle navigation
      // when auth state changes. Emitting state while navigating causes provider errors.
    } catch (e) {
      // Only emit failure if sign out actually failed
      if (!emit.isDone) {
        emit(ProfileLoadFailure(e.toString()));
      }
    }
  }
}
