import 'package:get/get.dart';
import '../models/cart.dart';
import '../services/cart_service.dart';

class CartController extends GetxController {
  final _service = CartService();

  final items = <Cart>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    items.value = _service.getCartItems();
  }

  Future<void> addCartItem(Cart item) async {
    isLoading.value = true;
    error.value = '';
    try {
      await _service.addCart(item);
      loadCart();
    } catch (e) {
      error.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeCartItem(String name) async {
    await _service.removeCart(name);
    loadCart();
  }

  Future<void> clearAllCart() async {
    await _service.clearCart();
    loadCart();
  }
}
