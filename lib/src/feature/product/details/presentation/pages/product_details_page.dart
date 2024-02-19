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
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      bottomNavigationBar: state.when(
        data: (data) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).copyWith(bottom: 30),
          child: Row(
            children: [
              // Price and Add to card button
              Expanded(
                flex: 0,
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFEBEBEB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      '\$${data?.price}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        error: (_, __) => const Offstage(),
        loading: () => const Offstage(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: state.when(
          data: (product) {
            return _ProductDetailsBuilder(product: product!);
          },
          loading: () => const ProductDetailsLoadingShimmer(),
          error: (error, stackTrace) {
            return const Center(child: Text('Error'));
          },
        ),
      ),
    );
  }
}
