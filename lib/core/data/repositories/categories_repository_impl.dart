import 'package:be_board/core/data/datasources/categories_remote_data_source.dart';
import 'package:be_board/core/domain/entities/category.dart';
import 'package:be_board/core/domain/entities/condition.dart';
import 'package:be_board/core/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getCategories() {
    return remoteDataSource.getCategories();
  }

  @override
  Future<List<Condition>> getConditions() {
    return remoteDataSource.getConditions();
  }
}
