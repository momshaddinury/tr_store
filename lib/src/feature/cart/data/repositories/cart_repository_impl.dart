import 'dart:developer';

import 'package:tr_store/src/feature/cart/data/data_sources/local/cart_local_data_source.dart';
import 'package:tr_store/src/feature/cart/data/models/cart_data.dart';
import 'package:tr_store/src/feature/cart/domain/entities/cart_entity.dart';
import 'package:tr_store/src/feature/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource local;

  CartRepositoryImpl({required this.local});

  @override
  Future<void> addToCart(CartEntity data) {
    return local.addToCart(data.toDBJson());
  }

  @override
  Future<void> deleteCart() {
    return local.deleteCart();
  }

  @override
  Future<List<CartEntity>> getCart() {
    return local.getCart().then(
      (value) {
        log('value: $value');
        return value.map(
          (e) {
            return CartData.fromJson(e);
          },
        ).toList();
      },
    );
  }

  @override
  Future<void> updateCart(CartEntity data) {
    return local.updateCart(data.toDBJson());
  }
}
