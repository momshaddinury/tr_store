import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/widgets/category_pill.dart';
import 'package:tr_store/src/core/widgets/quantity_button.dart';
import 'package:tr_store/src/feature/cart/domain/entities/cart_entity.dart';
import 'package:tr_store/src/feature/cart/presentation/riverpod/cart_provider.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

class CartItem extends ConsumerWidget {
  const CartItem({
    super.key,
    required this.cart,
  });

  final CartEntity cart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProductEntity product = cart.product;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: product.image,
              cacheKey: product.image,
              height: 100,
              width: 100,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                CategoryPill(category: product.category),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuantityButton(
                      vertical: false,
                      quantity: cart.quantity,
                      onChanged: (value) {
                        ref
                            .read(cartProvider.notifier)
                            .updateItem(cart.product, value);
                      },
                    ),
                    Text(
                      '\$${product.price}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
