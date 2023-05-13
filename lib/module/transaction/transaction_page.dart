import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.pets),
                    const SizedBox(width: 8),
                    const Icon(Icons.more_vert),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Order ID: 1234567890'),
                        Text('Order Date: 12-12-2021'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Divider(),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('Total: '),
                            Text('Rp. 100.000'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Text('Status: '),
                            Text('Delivered'),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: const [
                            Text('Quantity: '),
                            Text('1'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Text('Payment: '),
                            Text('Cash'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
