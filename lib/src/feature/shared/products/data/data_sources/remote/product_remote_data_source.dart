import 'package:flutter_network/flutter_network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/core/services/network/network.dart';

import 'product_remote_data_source_imp.dart';

part 'product_remote_data_source.g.dart';

@riverpod
ProductRemoteDataSourceImpl productRemoteDataSource(
  ProductRemoteDataSourceRef ref,
) {
  return ProductRemoteDataSourceImpl(client: ref.read(dioProvider));
}

abstract class ProductRemoteDataSource {
  Future<Response> fetchProductList();

  Future<Response> fetchProduct(int id);
}
