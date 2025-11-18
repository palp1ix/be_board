import 'package:be_board/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<User?> call(String email, String password) {
    return _repository.login(email, password);
  }
}
