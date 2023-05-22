import 'package:exopets/module/checkout/checkout_controller.dart';
import 'package:exopets/module/checkout/widget/add_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListAddress extends StatelessWidget {
  ListAddress({super.key});

  final CheckoutController checkoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Address'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[200],
      body: GetBuilder<CheckoutController>(
        init: CheckoutController(),
        initState: (_) {},
        builder: (_) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: checkoutController.address.length,
            itemBuilder: (context, index) {
              final address = checkoutController.address[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  onTap: () {
                    checkoutController.selectAddress(address);
                    Get.back();
                  },
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(address.name!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(address.phone!),
                      Text(address.address ?? ''),
                      Text(
                          '${address.city}, ${address.province}, ${address.postalCode}'),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      checkoutController.deleteAddress(address.id!);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddAdress());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
