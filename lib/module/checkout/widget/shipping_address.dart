import 'package:flutter/material.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
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
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 16),
              const Text('Shipping Address'),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Change'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('John Doe'),
          const SizedBox(height: 8),
          const Text('08123456789'),
          const SizedBox(height: 8),
          const Text('Jl. Raya Kebayoran Lama No. 12'),
          const SizedBox(height: 8),
          const Text('Jakarta Selatan, DKI Jakarta'),
        ],
      ),
    );
  }
}
