import 'package:flutter_network/flutter_network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/core/services/network/network.dart';

import 'product_data_source_imp.dart';

part 'product_data_source.g.dart';

@riverpod
ProductDataSourceImpl productDataSource(ProductDataSourceRef ref) {
  return ProductDataSourceImpl(client: ref.read(dioProvider));
}

abstract class ProductDataSource {
  Future<Response> fetchProductList();

  Future<Response> fetchProduct(int id);
}
