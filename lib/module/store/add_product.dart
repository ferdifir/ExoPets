import 'dart:io';

import 'package:exopets/module/store/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<String> categoryChoices = [
    'Reptil',
    'Burung',
    'Mamalia',
    'Amfibi',
    'Ikan',
    'Serangga',
    'Primata Kecil',
    'Mamalia Kecil',
  ];
  final List<String> sexChoices = ['Jantan', 'Betina'];
  final List<String> healthyChoices = ['Sehat', 'Sakit'];
  int selectedCategory = 0;
  int selectedSex = 0;
  int selectedHealthy = 0;
  final StoreController storeController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.only(top: 16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // create form for add product
                // image
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Obx(() => InkWell(
                        onTap: () {
                          storeController.pickImage();
                        },
                        child: storeController.selectedImage.value.isEmpty
                            ? const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 100,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  File(storeController.selectedImage.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      )),
                ),
                const Text(
                  '* klik untuk upload gambar',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                // name
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Spesies hewan tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: 'Spesies Hewan',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sex',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                // choicechip to choose sex
                Wrap(
                  spacing: 8,
                  children: sexChoices.map((choice) {
                    return ChoiceChip(
                      label: Text(choice),
                      selected: selectedSex == sexChoices.indexOf(choice),
                      onSelected: (selected) {
                        setState(() {
                          selectedSex =
                              selected ? sexChoices.indexOf(choice) : -1;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                // choicechip to choose category
                Wrap(
                  spacing: 8,
                  children: categoryChoices.map((choice) {
                    return ChoiceChip(
                      label: Text(choice),
                      selected:
                          selectedCategory == categoryChoices.indexOf(choice),
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory =
                              selected ? categoryChoices.indexOf(choice) : -1;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kesehatan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                // choicechip to choose healthy
                Wrap(
                  spacing: 8,
                  children: healthyChoices.map((choice) {
                    return ChoiceChip(
                      label: Text(choice),
                      selected:
                          selectedHealthy == healthyChoices.indexOf(choice),
                      onSelected: (selected) {
                        setState(() {
                          selectedHealthy =
                              selected ? healthyChoices.indexOf(choice) : -1;
                        });
                      },
                    );
                  }).toList(),
                ),
                // description
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi produk tidak boleh kosong';
                    }
                    return null;
                  },
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: 'Deskripsi Produk',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '* deskripsi merupakan informasi singkat mengenai hewan yang akan dijual',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                // price
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga produk tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: 'Harga Produk',
                  ),
                ),
                const Text(
                  '* jika harga produk 100.000 maka masukkan 100',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                // stock
                const SizedBox(height: 16),
                TextFormField(
                  controller: ageController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Umur hewan tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: 'Umur Hewan',
                  ),
                ),
                const Text(
                  '* umur hewan dalam bulan',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                // button submit
                const SizedBox(height: 16),
                // button submit
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      Get.dialog(const Center(
                        child: CircularProgressIndicator(),
                      ));
                      // do something
                      String? res = await storeController.uploadProduct(
                        species: nameController.text,
                        category: categoryChoices[selectedCategory],
                        age: ageController.text,
                        health: healthyChoices[selectedHealthy],
                        sex: sexChoices[selectedSex],
                        price: priceController.text,
                        description: descriptionController.text,
                      );
                      if (res == null) {
                        Get.back();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Perhatian'),
                              content:
                                  const Text('Produk berhasil ditambahkan'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
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
                              title: const Text('Perhatian'),
                              content: Text(res),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Tambah Produk'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
