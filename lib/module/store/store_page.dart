import 'package:exopets/module/info/info_pet.dart';
import 'package:exopets/module/store/edit_store.dart';
import 'package:exopets/module/store/store_controller.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorePage extends StatelessWidget {
  StorePage({super.key});

  final StoreController storeController = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    bool state = storeController.uid == storeController.auth.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Saya'),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          state
              ? IconButton(
                  onPressed: () {
                    storeController.setStore();
                    Get.to(() => EditStore());
                  },
                  icon: const Icon(Icons.settings),
                )
              : const SizedBox(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      floatingActionButton: state
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.ADD_PRODUCT);
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: GetBuilder<StoreController>(
        init: StoreController(),
        initState: (_) {},
        builder: (_) {
          if (_.store.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 16),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(
                        storeController.store['profile_picture'] ??
                            'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              storeController.store['nama_toko'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.storefront,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  storeController.store['alamat'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: Text(
                                storeController.store['description'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          _.products.length.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Produk',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _.transaction.length.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Transaksi',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Rp ${_.transaction.fold(0, (sum, item) => sum + item.total)}.000',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Penghasilan',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    itemCount: _.products.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Get.to(
                          () => const InfoPet(),
                          arguments: _.products[index].id,
                        ),
                        child: Image.network(
                          _.products[index].image!,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
