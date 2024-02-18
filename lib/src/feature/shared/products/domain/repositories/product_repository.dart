import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/network/error_model.dart';
import 'package:tr_store/src/feature/shared/products/data/data_sources/product_data_source.dart';
import 'package:tr_store/src/feature/shared/products/data/repositories/product_repository_imp.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

final productRepositoryProvider = Provider(
  (ref) {
    return ProductRepositoryImpl(
      dataSource: ref.read(productDataSourceProvider),
    );
  },
);

abstract class ProductRepository {
  Future<Either<ErrorModel, List<ProductEntity>>> productList();

  Future<Either<ErrorModel, ProductEntity>> product(int id);
}
