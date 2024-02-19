import 'package:tr_store/src/core/services/local_database/local_database.dart';

import 'cart_local_data_source.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final LocalDatabase database;

  CartLocalDataSourceImpl({required this.database});

  @override
  Future<List<Map<String, dynamic>>> getCart() async {
    return await database.rawQuery('''
    SELECT c.product_id, c.quantity, p.title, p.price, p.description, p.category, p.image
    FROM ${LocalDatabase.cartTable} AS c
    JOIN ${LocalDatabase.productsTable} AS p ON c.product_id = p.id
  ''');
  }

  @override
  Future<void> addToCart(Map<String, dynamic> data) async {
    await database.insert(LocalDatabase.cartTable, data);
  }

  @override
  Future<void> updateCart(Map<String, dynamic> data) async {
    await database.update(LocalDatabase.cartTable, data);
  }

  @override
  Future<void> deleteCart() async {
    await database.delete(LocalDatabase.cartTable, null);
  }
}
