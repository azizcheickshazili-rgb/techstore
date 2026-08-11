class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final double rating;
  final int stock;
  final String brand;
  final String description;
  final List<String> specs;
  final String image;
  final String? badge;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.description,
    required this.specs,
    required this.image,
    this.badge,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as String,
    name: json['name'] as String,
    category: json['category'] as String,
    price: (json['price'] as num).toDouble(),
    oldPrice: (json['oldPrice'] as num?)?.toDouble(),
    rating: (json['rating'] as num).toDouble(),
    stock: json['stock'] as int,
    brand: json['brand'] as String,
    description: json['description'] as String,
    specs: List<String>.from(json['specs'] as List),
    image: json['image'] as String,
    badge: json['badge'] as String?,
  );
}