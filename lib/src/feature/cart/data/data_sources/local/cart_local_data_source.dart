import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/core/services/local_database/local_database_provider.dart';
import 'package:tr_store/src/feature/cart/data/data_sources/local/cart_local_data_source_impl.dart';

part 'cart_local_data_source.g.dart';

@riverpod
CartLocalDataSourceImpl cartLocalDataSource(CartLocalDataSourceRef ref) {
  return CartLocalDataSourceImpl(
    database: ref.read(localDatabaseProvider),
  );
}

abstract class CartLocalDataSource {
  Future<List<Map<String, dynamic>>> getCart();

  Future<void> addToCart(Map<String, dynamic> data);

  Future<void> updateCart(Map<String, dynamic> data);

  Future<void> deleteCart();
}
