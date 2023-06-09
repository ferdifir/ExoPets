import 'package:exopets/model/payment.dart';
import 'package:exopets/module/admin/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageOrder extends StatelessWidget {
  const ManageOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      init: AdminController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Manage Orders'),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            centerTitle: true,
            leading: const SizedBox(),
            elevation: 0,
          ),
          backgroundColor: Colors.grey[200],
          body: controller.listTransaction.isEmpty
              ? const Center(
                  child: Text('No Transaction'),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.listTransaction.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.listTransaction[index];
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
                              const Icon(Icons.payments),
                              const SizedBox(width: 8),
                              const Icon(Icons.more_vert),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order ID: ${transaction.tid}'),
                                  Text(
                                      'Order Date: ${transaction.transactionDate.toString().substring(0, 10)}'),
                                ],
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  Get.dialog(
                                    buildDetailPaymentDialog(
                                      transaction,
                                      context,
                                      controller,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text('Detail'),
                              ),
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
                                        Text(
                                            'Rp. ${transaction.totalAmount}.000'),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Text('Status: '),
                                        Text(transaction.status!),
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
                                        Text(transaction.paymentMethod!),
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
                ),
        );
      },
    );
  }

  Dialog buildDetailPaymentDialog(
    Payment transaction,
    BuildContext context,
    AdminController controller,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Image.network(
            transaction.bankTransferInfo!,
            width: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            "Nama Pengirim: ${transaction.senderName!}",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel'),
              ),
              transaction.status! != 'Awaiting Payment'
                  ? Container()
                  : OutlinedButton(
                      onPressed: () {
                        Get.back();
                        Get.defaultDialog(
                          title: 'Confirm Payment',
                          content: const Text(
                            'Are you sure to confirm this payment?',
                          ),
                          textConfirm: 'Confirm',
                          textCancel: 'Cancel',
                          onConfirm: () {
                            Get.back();
                            controller
                                .updateStatusTransaction(
                                    transaction.transactionId!)
                                .then((value) {
                              Get.defaultDialog(
                                title: 'Success',
                                content: const Text(
                                  'Payment confirmed!',
                                ),
                                textConfirm: 'OK',
                                onConfirm: () {
                                  Get.back();
                                  Get.back();
                                },
                              );
                            });
                          },
                        );
                      },
                      child: const Text('Confirm'),
                    ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
