import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

class CartEntity {
  CartEntity({
    required this.product,
    required this.quantity,
  });

  final ProductEntity product;
  final int quantity;

  CartEntity copyWith({
    ProductEntity? product,
    int? quantity,
  }) {
    return CartEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
