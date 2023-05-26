import 'package:exopets/common/widget/custome_back_button.dart';
import 'package:exopets/module/checkout/checkout_controller.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const CustomBackButton(),
      ),
      body: GetBuilder<CheckoutController>(
        init: CheckoutController(),
        initState: (_) {},
        builder: (_) {
          if (_.cart.isEmpty) {
            return const Center(
              child: Text('Cart is empty'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
                bottom: 70,
              ),
              itemCount: _.cart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      _.cart[index].image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(_.cart[index].title),
                  subtitle: Text('Rp ${_.cart[index].price}.000'),
                  trailing: IconButton(
                    onPressed: () async {
                      bool res = await _.deleteFromCart(_.cart[index].id);
                      if (res) {
                        _.getCart();
                      } else {
                        Get.snackbar(
                          'Error',
                          'Failed to delete item from cart',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (checkoutController.cart.length > 1) {
            Get.snackbar(
              'Error',
              'Only one item can be purchased at a time',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            Get.toNamed(Routes.CHECKOUT);
          }
        },
        label: const Text('Checkout'),
        icon: const Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
