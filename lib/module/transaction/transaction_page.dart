import 'package:exopets/module/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});

  final transactionController = Get.put(TransactionController());

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
        body: GetBuilder<TransactionController>(
          init: transactionController,
          initState: (_) {},
          builder: (_) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: transactionController.transaction.length,
              itemBuilder: (context, index) {
                final transaction = transactionController.transaction[index];
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
                            children: [
                              Text('Order ID: ${transaction.id}'),
                              Text(
                                  'Order Date: ${transaction.date.toString().substring(0, 10)}'),
                            ],
                          ),
                          const Spacer(),
                          transaction.paymentMethod == 'Bank Transfer'
                              ? ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    minimumSize: const Size(64, 30),
                                  ),
                                  child: const Text(
                                    'Bayar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Divider(),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('Total: '),
                                    Text('Rp. ${transaction.total}.000'),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Text('Status: '),
                                    Text(transaction.status),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Text('Quantity: '),
                                    Text(transaction.quantity.toString()),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Text('Payment: '),
                                    Text(transaction.paymentMethod),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
