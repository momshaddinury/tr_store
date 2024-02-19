import 'package:dartz/dartz.dart';
import 'package:tr_store/src/core/services/network/error_model.dart';
import 'package:tr_store/src/core/services/network/request_handler.dart';
import 'package:tr_store/src/feature/shared/category/data/data_sources/category_data_source.dart';
import 'package:tr_store/src/feature/shared/category/data/models/category_model.dart';
import 'package:tr_store/src/feature/shared/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required this.dataSource,
  });

  final CategoryDataSource dataSource;

  @override
  Future<Either<ErrorModel, List<String>>> categories() async {
    return await dataSource.categories().guard((data) {
      return categoryModelFromJson(data);
    });
  }
}
