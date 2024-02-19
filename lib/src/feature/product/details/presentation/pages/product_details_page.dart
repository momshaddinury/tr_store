import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/widgets/cart_icon.dart';
import 'package:tr_store/src/core/widgets/category_pill.dart';
import 'package:tr_store/src/feature/cart/presentation/riverpod/cart_provider.dart';
import 'package:tr_store/src/feature/product/details/presentation/riverpod/product_details_notifier.dart';
import 'package:tr_store/src/feature/product/details/presentation/widgets/add_to_cart_button.dart';
import 'package:tr_store/src/feature/product/details/presentation/widgets/price.dart';
import 'package:tr_store/src/feature/product/details/presentation/widgets/product_details_loading_shimmer.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final int productId;

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailsProvider(widget.productId));
    final checkIfProductIsInCart =
        ref.watch(checkIfProductIsInCartProvider(widget.productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: const [CartIcon()],
      ),
      bottomNavigationBar: state.when(
        data: (data) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).copyWith(bottom: 30),
          child: Row(
            children: [
              Price(price: data!.price),
              const Spacer(),
              AddToCartButton(
                disabled: checkIfProductIsInCart,
                onPressed: () {
                  ref.read(cartProvider.notifier).addItem(data);
                },
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
            return RefreshIndicator(
              onRefresh: () =>
                  ref.refresh(productDetailsProvider(product.id).future),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: CachedNetworkImage(
                            imageUrl: product!.image,
                            cacheKey: product.image,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: 250,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      // QuantityButton(onChanged: (value) => quantity = value),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 8),
                      CategoryPill(category: product.category),
                      const SizedBox(height: 12),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            );
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
