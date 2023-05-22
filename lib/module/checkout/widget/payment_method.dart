import 'package:exopets/module/checkout/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({
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
              Icon(Icons.payment),
              SizedBox(width: 16),
              Text('Payment Method'),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              Get.bottomSheet(
                DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.5,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            width: 64,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.credit_card),
                            title: const Text('Credit Card'),
                            onTap: () {
                              checkoutController
                                  .selectPaymentMethod('Credit Card');
                              Navigator.pop(context);
                            },
                            trailing: isSelected('Credit Card')
                                ? const Icon(Icons.check)
                                : null,
                          ),
                          ListTile(
                            leading: const Icon(Icons.credit_card),
                            title: const Text('Bank Transfer'),
                            onTap: () {
                              checkoutController
                                  .selectPaymentMethod('Bank Transfer');
                              Navigator.pop(context);
                            },
                            trailing: isSelected('Bank Transfer')
                                ? const Icon(Icons.check)
                                : null,
                          ),
                          ListTile(
                            leading: const Icon(Icons.credit_card),
                            title: const Text('Cash on Delivery'),
                            onTap: () {
                              checkoutController
                                  .selectPaymentMethod('Cash on Delivery');
                              Navigator.pop(context);
                            },
                            trailing: isSelected('Cash on Delivery')
                                ? const Icon(Icons.check)
                                : null,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            child: GetBuilder<CheckoutController>(
              init: CheckoutController(),
              initState: (_) {},
              builder: (_) {
                return Row(
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
                    Text(checkoutController.selectedPaymentMethod),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isSelected(String method) {
    return checkoutController.selectedPaymentMethod == method;
  }
}
