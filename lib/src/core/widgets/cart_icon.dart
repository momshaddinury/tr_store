import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tr_store/src/core/services/navigation/routers.dart';
import 'package:tr_store/src/feature/cart/presentation/riverpod/cart_provider.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              context.pushNamed(Routes.cart);
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                ref.watch(cartItemCountProvider).toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
