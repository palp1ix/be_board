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
      // After signing out, we might want to emit an initial state or a specific
      // signed-out state, but for now, we do nothing to allow the navigator's
      // redirect logic to handle the screen transition.
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }
}
