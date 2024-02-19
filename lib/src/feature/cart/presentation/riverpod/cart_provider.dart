import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/feature/cart/data/models/cart_data.dart';
import 'package:tr_store/src/feature/cart/domain/entities/cart_entity.dart';
import 'package:tr_store/src/feature/cart/domain/use_cases/cart_use_case.dart';
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
  late CartUseCase useCase;

  @override
  List<CartEntity> build() {
    useCase = ref.read(cartUseCaseProvider);
    getCart();
    return cart;
  }

  Future<void> getCart() async {
    cart = await useCase.getCart();
    state = List.from(cart);
  }

  Future<void> addItem(ProductEntity product) async {
    final index = cart.indexWhere(
      (element) {
        return element.product.id == product.id;
      },
    );
    if (index != -1) {
      cart[index] = cart[index].copyWith(quantity: cart[index].quantity + 1);
      await useCase.updateCart(cart[index]);
    } else {
      await useCase.addToCart(CartEntity(product: product, quantity: 1));
    }

    getCart();
  }

  Future<void> updateItem(ProductEntity product, int quantity) async {
    final index = cart.indexWhere(
      (element) {
        return element.product.id == product.id;
      },
    );
    if (index != -1) {
      cart[index] = CartData(quantity: quantity, product: product);
      await useCase.updateCart(cart[index]);
    }
    getCart();
  }

  Future<void> clearCart() async {
    await useCase.deleteCart();
    getCart();
  }
}
