class ProductEntity {
  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  int id;
  String title;
  double price;
  String description;
  String category;
  String image;

  @override
  int compareTo(ProductEntity other) {
    return id.compareTo(other.id);
  }

  @override
  bool operator ==(covariant ProductEntity other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProductEntity(id: $id, title: $title, price: $price, description: $description, category: $category, image: $image)';
  }
}
