import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_network/flutter_network.dart';
import 'package:tr_store/src/core/services/network/error_model.dart';
import 'package:tr_store/src/feature/shared/category/data/data_sources/local/category_local_data_source.dart';
import 'package:tr_store/src/feature/shared/category/data/data_sources/remote/category_remote_data_source.dart';
import 'package:tr_store/src/feature/shared/category/data/models/category_model.dart';
import 'package:tr_store/src/feature/shared/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required this.remote,
    required this.local,
  });

  final CategoryRemoteDataSource remote;
  final CategoryLocalDataSource local;

  @override
  Future<Either<ErrorModel, List<String>>> categories() async {
    try {
      List<String> categories = await local.fetchCategoryList();

      if (categories.isEmpty) {
        final response = await remote.categories();
        categories = categoryModelFromJson(response.data);

        await local.cacheCategoryList(categories);
      }
      return Right(categories);
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
