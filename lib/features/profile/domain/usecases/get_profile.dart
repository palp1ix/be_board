import 'package:be_board/features/profile/domain/entities/profile.dart';
import 'package:be_board/features/profile/domain/repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Profile> call() async {
    return await repository.getProfile();
  }
}
