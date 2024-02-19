import 'package:tr_store/src/core/services/local_database/local_database.dart';

import 'product_local_data_source.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final LocalDatabase database;

  ProductLocalDataSourceImpl({required this.database});

  @override
  Future<List<Map<String, dynamic>>> fetchProductList() {
    return database.read(LocalDatabase.productsTable);
  }

  @override
  Future<void> saveProductList(data) async {
    for (var item in data) {
      await database.insert(
        LocalDatabase.productsTable,
        (item as Map<String, dynamic>)..remove('rating'),
      );
    }
    return;
  }

  @override
  Future<void> updateProductList(data) async {
    for (var item in data) {
      await database.update(
        LocalDatabase.productsTable,
        (item as Map<String, dynamic>)..remove('rating'),
      );
    }
    return;
  }

  @override
  Future<Map<String, dynamic>> fetchProduct(int id) async {
    return (await database.read(LocalDatabase.productsTable, id: id)).first;
  }
}
