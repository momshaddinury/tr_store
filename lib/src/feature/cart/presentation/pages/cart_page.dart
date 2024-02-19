import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/feature/cart/presentation/riverpod/cart_provider.dart';
import 'package:tr_store/src/feature/cart/presentation/widgets/cart_item.dart';
import 'package:tr_store/src/feature/cart/presentation/widgets/pricing_information.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Cart'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: 10, bottom: 30),
        child: SizedBox(
          height: 50,
          child: TextButton(
            onPressed: () {
              ref.read(cartProvider.notifier).clearCart();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cart.isEmpty)
              Center(
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 100,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your cart is empty',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black45,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    key: ValueKey(cart[index].product.id),
                    cart: cart[index],
                  );
                },
              ),
              const SizedBox(height: 16),
              const PricingInformation(),
              const SizedBox(height: 100),
            ]
          ],
        ),
      ),
    );
  }
}
