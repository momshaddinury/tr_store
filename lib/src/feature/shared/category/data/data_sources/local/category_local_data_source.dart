import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/core/services/local_database/local_database_provider.dart';
import 'package:tr_store/src/feature/shared/category/data/data_sources/local/category_local_data_source_impl.dart';

part 'category_local_data_source.g.dart';

@riverpod
CategoryLocalDataSourceImpl categoryLocalDataSource(
  CategoryLocalDataSourceRef ref,
) {
  return CategoryLocalDataSourceImpl(
    database: ref.read(localDatabaseProvider),
  );
}

abstract class CategoryLocalDataSource {
  Future<void> cacheCategoryList(dynamic data);

  Future<List<String>> fetchCategoryList();
}
