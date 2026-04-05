import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/my_color.dart';
import '../controllers/auth_controller.dart';
import '../controllers/product-controller.dart';
import '../controllers/cart_controller.dart';
import '../models/cart.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final _auth = Get.find<AuthController>();
  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // small padding
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: Icon(Icons.search),
                        isDense: true, // reduce internal padding
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColor.primaryColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          productController.fetchProducts();
                        } else {
                          productController.products.value =
                              productController.search(value);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.logout, size: 28),
                    onPressed: _auth.logout,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (productController.error.value.isNotEmpty) {
                  return Center(child: Text(productController.error.value));
                }

                final products = productController.products;

                if (products.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                return RefreshIndicator(
                  onRefresh: () => productController.refreshProducts(),
                  color: MyColor.primaryColor,
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        color: Colors.white,
                        child: ListTile(
                          leading: product.image != null
                              ? Image.network(
                            product.image!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                              : Icon(Icons.image_not_supported, color: MyColor.primaryColor),
                          title: Text(
                            product.name ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${product.category ?? ''} / ${product.subCategory ?? ''}\n\$${product.price.toStringAsFixed(2)}',
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.add_shopping_cart, color: MyColor.primaryColor),
                            onPressed: () {
                              final cartItem = Cart(
                                image: product.image ?? '',
                                name: product.name ?? '',
                                category: product.category ?? '',
                                subCategory: product.subCategory ?? '',
                                price: product.price,
                              );

                              cartController.addCartItem(cartItem);

                              Get.snackbar(
                                'Added to Cart',
                                '${product.name} has been added to your cart',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: MyColor.primaryColor.withOpacity(0.9),
                                colorText: Colors.white,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

