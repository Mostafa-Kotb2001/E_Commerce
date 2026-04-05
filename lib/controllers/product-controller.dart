import 'package:get/get.dart';
import 'package:E_Commerce/services/product_service.dart';
import '../../../models/product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      error.value = '';

      final result = await ProductService.getProducts();
      products.assignAll(result);
    } catch (e) {
      error.value = "Failed to load products";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }


  List<Product> getByCategory(String category) {
    return products
        .where((p) => p.category == category)
        .toList();
  }

  List<Product> search(String query) {
    return products.where((p) {
      final name = p.name?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();
  }
}
