import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signUp(String email, String password, String name, File? avatar);
  Future<User?> login(String email, String password);
  Future<void> signOut();
  User? get currentUser;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<User?> signUp(String email, String password, String name, File? avatar) async {
    try {
      final authResponse = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      final user = authResponse.user;

      if (user == null) return null;

      if (avatar != null) {
        final fileExt = avatar.path.split('.').last;
        final fileName = '${user.id}.$fileExt';
        final filePath = 'profile_avatars/$fileName';

        await _supabaseClient.storage.from('images').upload(
          filePath,
          avatar,
          fileOptions: const FileOptions(upsert: true),
        );

        final avatarUrl = _supabaseClient.storage.from('images').getPublicUrl(filePath);

        await _supabaseClient.from('profiles').update({
          'avatar_url': avatarUrl,
        }).eq('id', user.id);

        await _supabaseClient.auth.updateUser(
          UserAttributes(data: {'avatar_url': avatarUrl}),
        );
      }

      return _supabaseClient.auth.currentUser;

    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(email: email, password: password);
      return response.user;
    } catch (e) {
      // TODO: Handle exceptions
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;
}
