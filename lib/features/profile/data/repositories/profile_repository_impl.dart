import 'package:be_board/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:be_board/features/profile/domain/entities/profile.dart';
import 'package:be_board/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Profile> getProfile() async {
    final user = _remoteDataSource.currentUser;
    if (user != null) {
      final name = user.userMetadata?['name'] as String? ?? 'No Name';
      final email = user.email ?? 'No Email';
      final avatarUrl = user.userMetadata?['avatar_url'] as String?;
      return Profile(
        name: name,
        email: email,
        avatarUrl: avatarUrl,
      );
    } else {
      // This should ideally be a more specific exception
      throw Exception('User not authenticated');
    }
  }
}
