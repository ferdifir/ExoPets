import 'package:exopets/module/checkout/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAdress extends StatelessWidget {
  AddAdress({super.key});

  final CheckoutController checkoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              checkoutController.locateMe();
            },
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: GetBuilder<CheckoutController>(
        init: CheckoutController(),
        initState: (_) {},
        builder: (_) {
          return Container(
            margin: const EdgeInsets.all(16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Text('Alamat'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: checkoutController.addressController,
                  decoration: InputDecoration(
                    hintText: 'e.g. Jl. Raya Kebayoran Lama No. 12',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Kota'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: checkoutController.cityController,
                  decoration: InputDecoration(
                    hintText: 'e.g. Jakarta Selatan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Provinsi'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: checkoutController.provinceController,
                  decoration: InputDecoration(
                    hintText: 'e.g. DKI Jakarta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Kode Pos'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: checkoutController.postalCodeController,
                  decoration: InputDecoration(
                    hintText: 'e.g. 12345',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool res = await checkoutController.addAddress(
                          checkoutController.addressController.text,
                          checkoutController.cityController.text,
                          checkoutController.provinceController.text,
                          checkoutController.postalCodeController.text,
                        );
                        if (res) {
                          checkoutController.addressController.clear();
                          checkoutController.cityController.clear();
                          checkoutController.provinceController.clear();
                          checkoutController.postalCodeController.clear();
                          checkoutController.getAddress();
                          Get.back();
                        } else {
                          Get.snackbar(
                            'Error',
                            'Failed to add address',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Add Address'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
