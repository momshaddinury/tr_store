import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network/error_model.dart';
import 'package:tr_store/src/feature/shared/category/data/data_sources/category_data_source.dart';
import 'package:tr_store/src/feature/shared/category/data/repositories/category_repository_imp.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    dataSource: ref.watch(categoryDataSourceProvider),
  ),
);

abstract class CategoryRepository {
  Future<Either<ErrorModel, List<String>>> categories();
}
