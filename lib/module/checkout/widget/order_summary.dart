import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    Key? key,
  }) : super(key: key);

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
              itemCount: 3,
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
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Cat Food'),
                          SizedBox(height: 8),
                          Text('Rp 100.000'),
                        ],
                      ),
                      const Spacer(),
                      const Text('x1'),
                    ],
                  ),
                );
              }),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('Total'),
              Spacer(),
              Text('Rp 300.000'),
            ],
          ),
        ],
      ),
    );
  }
}
