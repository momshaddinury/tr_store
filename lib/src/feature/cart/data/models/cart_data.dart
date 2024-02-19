import 'package:tr_store/src/feature/cart/domain/entities/cart_entity.dart';
import 'package:tr_store/src/feature/shared/products/data/models/product_data.dart';

class CartData extends CartEntity {
  CartData({
    required super.quantity,
    required super.product,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      quantity: json["quantity"],
      product: ProductData(
        id: json['product_id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
        image: json['image'],
      ),
    );
  }

  @override
  Map<String, dynamic> toDBJson() {
    return {
      "quantity": quantity,
      "product_id": product.id,
    };
  }
}
