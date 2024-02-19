import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/feature/cart/presentation/riverpod/cart_provider.dart';

class PricingInformation extends ConsumerWidget {
  const PricingInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final price = ref.watch(totalCartPriceProvider);
    const double deliveryFee = 10;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sub Total', style: Theme.of(context).textTheme.titleMedium),
              Text('\$$price', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery', style: Theme.of(context).textTheme.titleMedium),
              Text('\$10', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: Theme.of(context).textTheme.titleMedium),
              Text(
                '\$${price + deliveryFee}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
