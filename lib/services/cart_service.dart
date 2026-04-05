import 'dart:convert';
import 'package:get/get.dart';
import '../models/cart.dart';
import 'initService.dart';

class CartService {
  final _storage = Get.find<InitServices>().sharedPreferences!;

  static const String _cartKey = 'cart_items';

  Future<void> addCart(Cart item) async {
    final List cart = jsonDecode(_storage.getString(_cartKey) ?? '[]');

    if (cart.any((c) => c['name'] == item.name)) {
      throw Exception('Item already in cart');
    }

    cart.add(item.toJson());
    await _storage.setString(_cartKey, jsonEncode(cart));
  }

  List<Cart> getCartItems() {
    final List cart = jsonDecode(_storage.getString(_cartKey) ?? '[]');
    return cart.map((c) => Cart.fromJson(c)).toList();
  }

  Future<void> removeCart(String name) async {
    final List cart = jsonDecode(_storage.getString(_cartKey) ?? '[]');
    cart.removeWhere((c) => c['name'] == name);
    await _storage.setString(_cartKey, jsonEncode(cart));
  }

  Future<void> clearCart() async {
    await _storage.remove(_cartKey);
  }
}
