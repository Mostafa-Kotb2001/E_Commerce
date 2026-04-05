class Cart {
  final String image;
  final String name;
  final String category;
  final String subCategory;
  final double price; // <-- add this

  Cart({
    required this.image,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.price, // <-- add this
  });

  Map<String, dynamic> toJson() => {
    'image': image,
    'name': name,
    'category': category,
    'subCategory': subCategory,
    'price': price, // <-- add this
  };

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    image: json['image'],
    name: json['name'],
    category: json['category'],
    subCategory: json['subCategory'],
    price: (json['price'] as num).toDouble(), // <-- add this
  );
}
