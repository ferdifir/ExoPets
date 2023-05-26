import 'package:exopets/module/checkout/checkout_controller.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/order_summary.dart';
import 'widget/payment_method.dart';
import 'widget/shipping_address.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CheckoutController checkoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ShippingAddress(),
          OrderSummary(),
          PaymentMethod(),
          //ShippingMethod(),
          Container(
            margin: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool res = await checkoutController.addToTransaction(
                    checkoutController.cart[0].id,
                    1,
                    checkoutController.cart[0].price,
                  );
                  if (res) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Order placed successfully'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.offAllNamed(Routes.DASHBOARD);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'Failed to place order',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Place Order'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
