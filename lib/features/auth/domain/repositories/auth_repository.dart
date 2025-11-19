import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<User?> signUp(
    String email,
    String password,
    String name,
    File? avatar,
  );
  Future<User?> login(String email, String password);
  Future<void> signOut();
  User? get currentUser;
}
