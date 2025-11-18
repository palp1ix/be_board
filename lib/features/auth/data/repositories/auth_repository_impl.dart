import 'dart:io';

import 'package:be_board/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:be_board/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User?> signUp(String email, String password, String name, File? avatar) {
    return _remoteDataSource.signUp(email, password, name, avatar);
  }

  @override
  Future<User?> login(String email, String password) {
    return _remoteDataSource.login(email, password);
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }

  @override
  User? get currentUser => _remoteDataSource.currentUser;
}
