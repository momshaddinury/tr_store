import 'package:flutter_network/flutter_network.dart';
import 'package:tr_store/src/core/services/network/api.dart';

import 'category_remote_data_source.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  CategoryRemoteDataSourceImpl({required this.client});

  final FlutterNetwork client;

  @override
  Future<Response> categories() async {
    final response = await client.get(API.categories);
    return response;
  }
}
