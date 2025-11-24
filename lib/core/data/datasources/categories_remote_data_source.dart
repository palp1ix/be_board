import 'package:be_board/core/domain/entities/category.dart';
import 'package:be_board/core/domain/entities/condition.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<Category>> getCategories();
  Future<List<Condition>> getConditions();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final SupabaseClient supabaseClient;

  CategoriesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<Category>> getCategories() async {
    final response = await supabaseClient
        .from('categories')
        .select()
        .order('name', ascending: true);

    return (response as List).map((e) => Category.fromJson(e)).toList();
  }

  @override
  Future<List<Condition>> getConditions() async {
    final response = await supabaseClient
        .from('conditions')
        .select()
        .order('name', ascending: true);

    return (response as List).map((e) => Condition.fromJson(e)).toList();
  }
}
