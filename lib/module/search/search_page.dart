import 'package:exopets/module/info/info_pet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
            elevation: 0,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    controller.searchPet(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Ketik jenis hewan peliharaan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => controller.products.isEmpty
                      ? const Center(
                          child: Text('Tidak ada produk yang ditemukan'),
                        )
                      : ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            final product = controller.products[index];
                            return ListTile(
                              onTap: () {
                                Get.to(
                                  () => const InfoPet(),
                                  arguments: product.id,
                                );
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.image!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(product.name!),
                              subtitle: Text("Rp ${product.price}.000"),
                              trailing: IconButton(
                                onPressed: () async {
                                  bool res =
                                      await controller.addTocart(product.id);
                                  if (res) {
                                    Get.snackbar(
                                      'Berhasil',
                                      'Produk berhasil ditambahkan ke keranjang',
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Gagal',
                                      'Anda sudah menambahkan produk ini ke keranjang',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                icon: const Icon(Icons.add_shopping_cart),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
