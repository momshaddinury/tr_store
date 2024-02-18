import 'package:flutter_network/flutter_network.dart';
import 'package:tr_store/src/core/network/api.dart';

import 'category_data_source.dart';

class CategoryDataSourceImpl implements CategoryDataSource {
  CategoryDataSourceImpl({
    required this.client,
  });

  final FlutterNetwork client;

  @override
  Future<Response> categories() async {
    final response = await client.get(API.categories);
    return response;
  }
}
