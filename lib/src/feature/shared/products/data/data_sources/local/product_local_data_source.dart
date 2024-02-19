import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/core/services/local_database/local_database_provider.dart';
import 'package:tr_store/src/feature/shared/products/data/data_sources/local/product_local_data_source_impl.dart';

part 'product_local_data_source.g.dart';

@riverpod
ProductLocalDataSourceImpl productLocalDataSource(
  ProductLocalDataSourceRef ref,
) {
  return ProductLocalDataSourceImpl(database: ref.read(localDatabaseProvider));
}

abstract class ProductLocalDataSource {
  Future<void> saveProductList(dynamic data);

  Future<void> updateProductList(dynamic data);

  Future<List<Map<String, dynamic>>> fetchProductList();
}
