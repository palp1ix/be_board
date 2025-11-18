import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRemoteDataSource {
  User? get currentUser;
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient _supabaseClient;

  ProfileRemoteDataSourceImpl(this._supabaseClient);

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;
}
