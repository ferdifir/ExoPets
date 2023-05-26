import 'package:exopets/module/store/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStore extends StatelessWidget {
  EditStore({super.key});

  final controller = Get.find<StoreController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Toko'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama toko tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nama Toko',
                  hintText: 'Masukkan nama toko',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Deskripsi toko tidak boleh kosong';
                  }
                  return null;
                },
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Toko',
                  hintText: 'Masukkan deskripsi toko',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Alamat toko tidak boleh kosong';
                  }
                  return null;
                },
                controller: controller.addressController,
                decoration: InputDecoration(
                  labelText: 'Alamat Toko',
                  hintText: 'Masukkan alamat toko',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.updateStore();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}