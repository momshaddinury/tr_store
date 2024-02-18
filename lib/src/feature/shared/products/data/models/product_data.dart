import 'package:tr_store/src/feature/shared/products/domain/entities/product_entity.dart';

class ProductData extends ProductEntity {
  ProductData({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
      );
}
