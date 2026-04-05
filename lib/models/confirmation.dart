import 'cart.dart';

class Confirmation {
  final List<Cart> items;
  final String phone;
  final String address;
  final double totalPrice;

  Confirmation({
    required this.items,
    required this.phone,
    required this.address,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() => {
    'items': items.map((e) => e.toJson()).toList(),
    'phone': phone,
    'address': address,
    'totalPrice': totalPrice,
  };

  factory Confirmation.fromJson(Map<String, dynamic> json) => Confirmation(
    items: (json['items'] as List)
        .map((e) => Cart.fromJson(e))
        .toList(),
    phone: json['phone'],
    address: json['address'],
    totalPrice: (json['totalPrice'] as num).toDouble(),
  );
}
