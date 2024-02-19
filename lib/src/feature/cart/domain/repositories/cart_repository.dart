import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tr_store/src/feature/cart/data/data_sources/local/cart_local_data_source.dart';
import 'package:tr_store/src/feature/cart/data/repositories/cart_repository_impl.dart';
import 'package:tr_store/src/feature/cart/domain/entities/cart_entity.dart';

part 'cart_repository.g.dart';

@riverpod
CartRepositoryImpl cartRepository(CartRepositoryRef ref) {
  return CartRepositoryImpl(
    local: ref.read(cartLocalDataSourceProvider),
  );
}

abstract class CartRepository {
  Future<List<CartEntity>> getCart();

  Future<void> addToCart(CartEntity cartEntity);

  Future<void> updateCart(CartEntity cartEntity);

  Future<void> deleteCart();
}
