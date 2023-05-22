import 'package:exopets/module/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateStore extends StatelessWidget {
  CreateStore({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Toko'),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nama Toko'),
                const SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama toko tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama toko',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Deskripsi Toko'),
                const SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Deskripsi toko tidak boleh kosong';
                    }
                    return null;
                  },
                  maxLength: 150,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan deskripsi toko',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Alamat Toko'),
                const SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat toko tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan alamat toko',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      String? res = await dashboardController.createMyStore(
                        nameController.text,
                        descriptionController.text,
                        addressController.text,
                      );
                      if (res == null) {
                        Get.back();
                        Get.back();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Berhasil'),
                              content: const Text('Toko berhasil dibuat'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.back();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Get.back();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Gagal'),
                              content: const Text('Toko gagal dibuat'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Buat Toko'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
