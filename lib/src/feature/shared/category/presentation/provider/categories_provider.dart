import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/feature/shared/category/domain/use_cases/category_use_case.dart';

part 'categories_provider.g.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => '');

@riverpod
Future<List<String>> getCategories(GetCategoriesRef ref) async {
  final categories = await ref.read(categoryUseCaseProvider).categories();

  return categories.fold(
    (l) {
      log(
        'getCategories',
        error: l,
      );
      return [];
    },
    (r) => r,
  );
}
