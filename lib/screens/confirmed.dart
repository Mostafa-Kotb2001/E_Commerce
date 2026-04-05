import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/my_color.dart';
import '../controllers/confirm_controller.dart';
import '../models/confirmation.dart';

class Confirmed extends StatelessWidget {
  Confirmed({super.key});

  final ConfirmationController confirmationController = Get.find<ConfirmationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final List<Confirmation> confirmations = confirmationController.confirmations;

        if (confirmations.isEmpty) {
          return const Center(
            child: Text('No confirmed orders yet'),
          );
        }

        return Column(
          children: [
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [

                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Confirmed Orders',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 40), // space for symmetry
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: confirmations.length,
                itemBuilder: (context, index) {
                  final Confirmation confirmation = confirmations[index];

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Items:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          ...confirmation.items.map(
                                (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  item.image.isNotEmpty
                                      ? Image.network(item.image,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover)
                                      : Icon(Icons.image_not_supported,
                                      color: MyColor.primaryColor, size: 50),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${item.name} (${item.category}/${item.subCategory})',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Phone: ${confirmation.phone}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Address: ${confirmation.address}',
                            style: const TextStyle(fontSize: 14),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Total: \$${confirmation.totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
