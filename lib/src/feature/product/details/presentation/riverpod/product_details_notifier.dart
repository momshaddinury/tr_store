import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/feature/product/details/domain/use_cases/product_details_use_case.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

final productDetailsProvider =
    FutureProvider.autoDispose.family<ProductEntity?, int>(
  (ref, value) async {
    try {
      final result =
          await ref.read(productDetailsUseCaseProvider).product(value);

      return result.fold(
        (l) => null,
        (r) {
          ref.keepAlive();
          return r;
        },
      );
    } catch (e, stackTrace) {
      log(
        'productDetailsProvider.futureProvider',
        error: e,
        stackTrace: stackTrace,
      );
    }

    return null;
  },
);
