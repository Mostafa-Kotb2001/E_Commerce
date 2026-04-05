import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product.dart';

class ProductService {
  static const String baseUrl =
      'https://kolzsticks.github.io/Free-Ecommerce-Products-Api/main/products.json';

  static Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
