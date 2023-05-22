import 'package:exopets/module/checkout/checkout_controller.dart';
import 'package:exopets/module/checkout/widget/list_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddress extends StatelessWidget {
  ShippingAddress({
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
      child: GetBuilder<CheckoutController>(
        init: CheckoutController(),
        initState: (_) {},
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 16),
                  const Text('Shipping Address'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.to(() => ListAddress());
                    },
                    child: const Text('Change'),
                  ),
                ],
              ),
              _.selectedAddress == null
                  ? const Text('No Address Selected')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(_.selectedAddress!.name!),
                        const SizedBox(height: 8),
                        Text(_
                            .selectedAddress!.phone!),
                        const SizedBox(height: 8),
                        Text(_.selectedAddress!.address ?? ''),
                        const SizedBox(height: 8),
                        Text(
                            '${_.selectedAddress!.city}, ${_.selectedAddress!.province}, ${_.selectedAddress!.postalCode}'),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
