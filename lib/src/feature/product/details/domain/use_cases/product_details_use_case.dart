import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/core/network/error_model.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';
import 'package:tr_store/src/feature/shared/products/domain/repositories/product_repository.dart';

part 'product_details_use_case.g.dart';

@riverpod
ProductDetailsUseCase productDetailsUseCase(ProductDetailsUseCaseRef ref) {
  return ProductDetailsUseCase(ref.read(productRepositoryProvider));
}

class ProductDetailsUseCase {
  ProductDetailsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<ErrorModel, ProductEntity>> product(int id) async {
    return await _repository.product(id);
  }
}
