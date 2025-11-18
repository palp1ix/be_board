import 'dart:io';

import 'package:be_board/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<User?> call(String email, String password, String name, File? avatar) {
    return _repository.signUp(email, password, name, avatar);
  }
}
