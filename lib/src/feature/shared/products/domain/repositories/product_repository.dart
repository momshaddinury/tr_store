import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network/error_model.dart';
import 'package:tr_store/src/feature/shared/products/data/data_sources/local/product_local_data_source.dart';
import 'package:tr_store/src/feature/shared/products/data/data_sources/remote/product_remote_data_source.dart';
import 'package:tr_store/src/feature/shared/products/data/repositories/product_repository_imp.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

final productRepositoryProvider = Provider(
  (ref) {
    return ProductRepositoryImpl(
      local: ref.read(productLocalDataSourceProvider),
      remote: ref.read(productRemoteDataSourceProvider),
    );
  },
);

abstract class ProductRepository {
  Future<Either<ErrorModel, List<ProductEntity>>> productList(
    bool forceRefresh,
  );

  Future<Either<ErrorModel, ProductEntity>> product(int id);
}
