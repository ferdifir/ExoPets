import 'package:flutter/material.dart';

class ShippingMethod extends StatelessWidget {
  const ShippingMethod({
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
              Icon(Icons.local_shipping_outlined),
              SizedBox(width: 16),
              Text('Shipping Method'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
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
              const Text('GoSend'),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ],
      ),
    );
  }
}