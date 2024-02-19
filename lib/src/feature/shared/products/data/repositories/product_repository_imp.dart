import 'package:dartz/dartz.dart';
import 'package:tr_store/src/core/services/network/error_model.dart';
import 'package:tr_store/src/core/services/network/request_handler.dart';
import 'package:tr_store/src/feature/shared/products/data/data_sources/product_data_source.dart';
import 'package:tr_store/src/feature/shared/products/data/models/product_data.dart';
import 'package:tr_store/src/feature/shared/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.dataSource});

  final ProductDataSource dataSource;

  @override
  Future<Either<ErrorModel, List<ProductData>>> productList() async {
    return await dataSource.fetchProductList().guard(
          (data) => (data as List).map((e) {
            return ProductData.fromJson(e);
          }).toList(),
        );
  }

  @override
  Future<Either<ErrorModel, ProductData>> product(int id) async {
    return await dataSource
        .fetchProduct(id)
        .guard((data) => ProductData.fromJson(data));
  }
}
