import 'package:flutter_network/flutter_network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/network/network.dart';

import 'category_data_source_imp.dart';

final categoryDataSourceProvider = Provider<CategoryDataSource>(
  (ref) => CategoryDataSourceImpl(
    client: ref.watch(dioProvider),
  ),
);

abstract class CategoryDataSource {
  Future<Response> categories();
}
