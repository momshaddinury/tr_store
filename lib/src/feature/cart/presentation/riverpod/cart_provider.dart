import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/feature/cart/domain/entities/cart_entity.dart';
import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

part 'cart_provider.g.dart';

final cartItemCountProvider = StateProvider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.length;
});

final checkIfProductIsInCartProvider = StateProvider.family<bool, int>(
  (ref, id) {
    final cart = ref.watch(cartProvider);
    return cart.any((element) => element.product.id == id);
  },
);

final totalCartPriceProvider = Provider<double>(
  (ref) {
    final cart = ref.watch(cartProvider);
    return cart.fold(
      0,
      (previousValue, element) {
        final value =
            previousValue + (element.product.price * element.quantity);
        return double.parse(value.toStringAsFixed(2));
      },
    );
  },
);

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  List<CartEntity> cart = [];

  @override
  List<CartEntity> build() {
    return cart;
  }

  void addItem(ProductEntity product) {
    final index = cart.indexWhere(
      (element) {
        return element.product.id == product.id;
      },
    );
    if (index != -1) {
      cart[index] = cart[index].copyWith(quantity: cart[index].quantity + 1);
    } else {
      cart.add(CartEntity(product: product, quantity: 1));
    }
    state = List.from(cart);
  }

  void updateItem(ProductEntity product, int quantity) {
    final index = cart.indexWhere(
      (element) {
        return element.product.id == product.id;
      },
    );
    if (index != -1) {
      cart[index] = cart[index].copyWith(quantity: quantity);
    }
    state = List.from(cart);
  }

  void clearCart() {
    cart = [];
    state = cart;
  }
}
