import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/feature/cart/domain/entities/cart_entity.dart';
import 'package:tr_store/src/feature/cart/domain/repositories/cart_repository.dart';

part 'cart_use_case.g.dart';

@riverpod
CartUseCase cartUseCase(CartUseCaseRef ref) {
  return CartUseCase(repository: ref.read(cartRepositoryProvider));
}

class CartUseCase {
  final CartRepository repository;

  CartUseCase({required this.repository});

  Future<List<CartEntity>> getCart() async {
    return await repository.getCart();
  }

  Future<void> addToCart(CartEntity cartEntity) async {
    return await repository.addToCart(cartEntity);
  }

  Future<void> updateCart(CartEntity cartEntity) async {
    return await repository.updateCart(cartEntity);
  }

  Future<void> deleteCart() async {
    return await repository.deleteCart();
  }
}
