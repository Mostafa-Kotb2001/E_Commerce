class Product {
  final String? id;
  final String? image;
  final String? name;
  final Rating? rating;
  final int? priceCents;
  final String? category;
  final String? subCategory;
  final List<String>? keywords;
  final String? description;

  Product({
    this.id,
    this.image,
    this.name,
    this.rating,
    this.priceCents,
    this.category,
    this.subCategory,
    this.keywords,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString(),
      image: json['image'],
      name: json['name'],
      rating: json['rating'] != null
          ? Rating.fromJson(json['rating'])
          : null,
      priceCents: json['priceCents'],
      category: json['category'],
      subCategory: json['subCategory'],
      keywords: json['keywords'] != null
          ? List<String>.from(json['keywords'])
          : [],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'rating': rating?.toJson(),
      'priceCents': priceCents,
      'category': category,
      'subCategory': subCategory,
      'keywords': keywords,
      'description': description,
    };
  }

  double get price => (priceCents ?? 0) / 100;
}

class Rating {
  final double? stars;
  final int? count;

  Rating({this.stars, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      stars: (json['stars'] as num?)?.toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stars': stars,
      'count': count,
    };
  }
}
