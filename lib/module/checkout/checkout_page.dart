import 'package:flutter/material.dart';

import 'widget/order_summary.dart';
import 'widget/payment_method.dart';
import 'widget/shipping_address.dart';
import 'widget/shipping_method.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

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
          // make container for the payment method
          PaymentMethod(),
          // make container for the shipping method
          ShippingMethod(),
          // make container for the button
          Container(
            margin: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
