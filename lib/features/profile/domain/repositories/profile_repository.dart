import 'package:be_board/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
}
