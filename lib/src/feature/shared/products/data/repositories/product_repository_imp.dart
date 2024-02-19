import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_network/flutter_network.dart';
import 'package:tr_store/src/core/services/network/error_model.dart';
import 'package:tr_store/src/feature/shared/products/data/data_sources/local/product_local_data_source.dart';
import 'package:tr_store/src/feature/shared/products/data/data_sources/remote/product_remote_data_source.dart';
import 'package:tr_store/src/feature/shared/products/data/models/product_data.dart';
import 'package:tr_store/src/feature/shared/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required this.remote,
    required this.local,
  });

  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;

  @override
  Future<Either<ErrorModel, List<ProductData>>> productList(
    bool forceRefresh,
  ) async {
    try {
      List<ProductData> products = [];
      List data;
      bool isCached = true;

      if (forceRefresh) {
        final response = await remote.fetchProductList();
        data = response.data;
      } else {
        data = await local.fetchProductList();

        if (data.isEmpty) {
          isCached = false;
          final response = await remote.fetchProductList();
          data = response.data;
        }
      }

      products = (data).map((e) {
        return ProductData.fromJson(e);
      }).toList();

      if (!isCached) {
        await local.saveProductList(data);
      }

      return Right(products);
    } on Failure catch (e, stacktrace) {
      log(
        runtimeType.toString(),
        error: {},
        stackTrace: stacktrace,
      );
      ErrorModel errorModel = ErrorModel.fromJson(e.error);

      return Left(errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, ProductData>> product(int id) async {
    try {
      dynamic data = await local.fetchProduct(id);

      if (data.isEmpty) {
        final response = await remote.fetchProduct(id);
        data = response.data;
      }

      ProductData product = ProductData.fromJson(data);

      return Right(product);
    } on Failure catch (e, stacktrace) {
      log(
        runtimeType.toString(),
        error: {},
        stackTrace: stacktrace,
      );
      ErrorModel errorModel = ErrorModel.fromJson(e.error);

      return Left(errorModel);
    }
  }
}
