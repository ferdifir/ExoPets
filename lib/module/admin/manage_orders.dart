import 'package:exopets/module/admin/admin_controller.dart';
import 'package:exopets/module/info/info_pet.dart';
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
          body: ListView.builder(
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
                            Text('Order ID: ${transaction.id}'),
                            Text('Order Date: ${transaction.date.toString().substring(0, 10)}'),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(
                              () => const InfoPet(),
                              arguments: {
                                'id': controller.listTransaction[index].productId,
                                'isFromAdmin': true,
                              }
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
          ),
        );
      },
    );
  }
}
