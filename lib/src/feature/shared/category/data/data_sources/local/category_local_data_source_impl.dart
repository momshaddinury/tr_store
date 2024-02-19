import 'package:tr_store/src/core/services/local_database/local_database.dart';
import 'package:tr_store/src/feature/shared/category/data/data_sources/local/category_local_data_source.dart';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final LocalDatabase database;

  CategoryLocalDataSourceImpl({
    required this.database,
  });

  @override
  Future<void> cacheCategoryList(data) async {
    for (var item in data) {
      await database.insert(
        LocalDatabase.categoriesTable,
        {'name': item},
      );
    }
    return;
  }

  @override
  Future<List<String>> fetchCategoryList() {
    return database.read(LocalDatabase.categoriesTable).then((value) {
      return value.map((e) => e['name'] as String).toList();
    });
  }
}
