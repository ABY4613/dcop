class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFeatured;
  final bool isNewArrival;
  final bool isTrending;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFeatured = false,
    this.isNewArrival = false,
    this.isTrending = false,
  });
}
