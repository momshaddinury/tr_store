import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/state/base_state.dart';
import 'package:tr_store/src/feature/product/products/domain/use_cases/products_use_case.dart';
import 'package:tr_store/src/feature/shared/category/presentation/provider/categories_provider.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

class ProductsNotifier extends StateNotifier<BaseState> {
  ProductsNotifier({
    required this.ref,
    required this.useCase,
  }) : super(InitialState()) {
    ref.listen(selectedCategoryProvider, (previous, next) {
      productList(hasFilter: previous != next && next.isNotEmpty);
    });
  }

  final Ref ref;
  final ProductsUseCase useCase;

  List<ProductEntity> _products = [];

  Future<void> productList(
      {bool hasFilter = false, bool forceRefresh = false}) async {
    if (hasFilter) {
      if (state is SuccessState) {
        String category = ref.read(selectedCategoryProvider);

        if (category.isNotEmpty) {
          List<ProductEntity> filteredProducts = _products
              .where((element) => element.category == category.toLowerCase())
              .toList();

          state = const LoadingState();
          await Future.delayed(const Duration(milliseconds: 100));

          state = SuccessState(
            data: filteredProducts.isEmpty ? _products : filteredProducts,
          );
        }

        return;
      }
    }

    state = const LoadingState();
    try {
      final result = await useCase.productList(forceRefresh);
      result.fold(
        (l) {
          log(
            'ProductsNotifier.productList',
            error: l,
          );
          return state = ErrorState(data: l.toString());
        },
        (r) {
          _products = r;
          return state = SuccessState(data: r);
        },
      );
    } catch (e, stacktrace) {
      log(
        'ProductsNotifier.productList',
        error: e,
        stackTrace: stacktrace,
      );
      state = ErrorState(data: e.toString());
    }
  }
}
