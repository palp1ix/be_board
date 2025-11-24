import 'package:be_board/core/domain/entities/category.dart';
import 'package:be_board/core/domain/entities/condition.dart';

abstract class CategoriesRepository {
  Future<List<Category>> getCategories();
  Future<List<Condition>> getConditions();
}
