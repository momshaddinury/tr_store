import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/feature/product/details/presentation/riverpod/product_details_notifier.dart';
import 'package:tr_store/src/feature/product/details/presentation/widgets/product_details_loading_shimmer.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

part '../widgets/product_details_builder.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final int productId;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(productDetailsProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: state.when(
        data: (product) {
          return _ProductDetailsBuilder(product: product!);
        },
        loading: () => const ProductDetailsLoadingShimmer(),
        error: (error, stackTrace) {
          return const Center(child: Text('Error'));
        },
      ),
    );
  }
}
