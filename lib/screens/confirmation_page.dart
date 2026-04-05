import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/my_color.dart';
import '../controllers/cart_controller.dart';
import '../models/cart.dart';

class ConfirmationPage extends StatelessWidget {
  ConfirmationPage({super.key});

  final CartController cartController = Get.put(CartController());

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  double getTotalPrice() {
    return cartController.items.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final items = cartController.items;

        if (cartController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (items.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }

        return Column(
          children: [
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, color: MyColor.primaryColor),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Confirmation Order',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final Cart item = items[index];
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: item.image.isNotEmpty
                              ? Image.network(
                            item.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                              : Icon(Icons.image_not_supported,
                              color: MyColor.primaryColor),
                          title: Text(item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${item.category} / ${item.subCategory}\n\$${item.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: MyColor.primaryColor,
                            onPressed: () {
                              cartController.removeCartItem(item.name);
                              Get.snackbar(
                                'Removed',
                                '${item.name} removed from cart',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor:
                                Colors.red.withOpacity(0.8),
                                colorText: Colors.white,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Text('Contact information', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: MyColor.primaryColor ,
            )),
            SizedBox(height: 8,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      prefixIcon: const Icon(Icons.phone),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your address',
                      prefixIcon: const Icon(Icons.location_on),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${getTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Confirm Order (${items.length} items)',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    if (items.isEmpty) {
                      Get.snackbar(
                        'Cart is empty',
                        'Add products before confirming',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.grey.shade700,
                        colorText: Colors.white,
                      );
                      return;
                    }

                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
