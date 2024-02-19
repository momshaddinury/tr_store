import 'package:flutter_network/flutter_network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network/network.dart';

import 'category_remote_data_source_imp.dart';

final categoryDataSourceProvider = Provider<CategoryRemoteDataSource>(
  (ref) => CategoryRemoteDataSourceImpl(
    client: ref.watch(dioProvider),
  ),
);

abstract class CategoryRemoteDataSource {
  Future<Response> categories();
}
