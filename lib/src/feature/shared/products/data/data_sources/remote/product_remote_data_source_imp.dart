import 'package:flutter_network/flutter_network.dart';
import 'package:tr_store/src/core/services/network/api.dart';

import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({
    required this.client,
  });

  final FlutterNetwork client;

  @override
  Future<Response> fetchProductList() async {
    return await client.get(API.products);
  }

  @override
  Future<Response> fetchProduct(int id) async {
    return await client.get('${API.products}/$id');
  }
}
