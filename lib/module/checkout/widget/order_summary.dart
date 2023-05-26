import 'package:exopets/module/checkout/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummary extends StatelessWidget {
  OrderSummary({
    Key? key,
  }) : super(key: key);

  final CheckoutController checkoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.shopping_cart_checkout),
              SizedBox(width: 16),
              Text('Order Summary'),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: checkoutController.cart.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(
                                checkoutController.cart[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(checkoutController.cart[index].title),
                          const SizedBox(height: 8),
                          Text('Rp ${checkoutController.cart[index].price}.000'),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              }),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              Text("Rp ${total().toString()}.000"),
            ],
          ),
        ],
      ),
    );
  }

  total() {
    int total = 0;
    for (var item in checkoutController.cart) {
      total += item.price;
    }
    return total;
  }
}
