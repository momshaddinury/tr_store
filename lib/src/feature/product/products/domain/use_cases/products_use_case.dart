import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network/error_model.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';
import 'package:tr_store/src/feature/shared/products/domain/repositories/product_repository.dart';

final productsUseCaseProvider = Provider(
  (ref) {
    return ProductsUseCase(
      ref.read(productRepositoryProvider),
    );
  },
);

class ProductsUseCase {
  ProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<ErrorModel, List<ProductEntity>>> productList(
      bool forceRefresh) async {
    return await _repository.productList(forceRefresh);
  }
}
