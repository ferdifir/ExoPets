import 'dart:io';

import 'package:exopets/module/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadBuktiTransfer extends StatelessWidget {
  UploadBuktiTransfer({super.key});

  TextEditingController nameController = TextEditingController();
  int id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bukti Transfer"),
      ),
      body: Container(
        width: Get.width,
        margin: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: GetBuilder<TransactionController>(
          init: TransactionController(),
          initState: (_) {},
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Obx(() {
                    return controller.selectedImage.value.isEmpty
                        ? Image.network(
                            'https://media.perkakasku.id/image/qrperkakasku.jpeg',
                            height: 500,
                          )
                        : Image.file(
                            File(controller.selectedImage.value),
                            height: 500,
                          );
                  }),
                  const SizedBox(height: 16),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    validator: (value) => value!.isEmpty
                        ? 'Nama Pemilik Rekening tidak boleh kosong'
                        : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Masukkan Nama Pemilik Rekening',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => ElevatedButton(
                        onPressed: () {
                          if (controller.selectedImage.value.isEmpty) {
                            controller.pickImage();
                          } else {
                            controller.addPayment(
                              id,
                              nameController.text,
                              controller.buktiUrl.value,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: const Size(200, 50),
                        ),
                        child: Text(
                          controller.selectedImage.value.isEmpty
                              ? 'Pilih Bukti Transfer'
                              : 'Upload Bukti Transfer',
                        ),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
