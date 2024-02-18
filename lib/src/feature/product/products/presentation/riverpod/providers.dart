import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/state/base_state.dart';
import 'package:tr_store/src/feature/product/products/domain/use_cases/products_use_case.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

import 'products_notifier.dart';

final productsProvider = StateNotifierProvider<ProductsNotifier, BaseState>(
  (ref) {
    return ProductsNotifier(
      ref: ref,
      useCase: ref.watch(productsUseCaseProvider),
    );
  },
);

final productDataProvider = Provider<ProductEntity>(
  (ref) => throw UnimplementedError(),
);
