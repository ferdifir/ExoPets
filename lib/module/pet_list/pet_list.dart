import 'package:exopets/model/products.dart';
import 'package:exopets/module/info/info_pet.dart';
import 'package:exopets/module/pet_list/pet_controller.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetList extends StatelessWidget {
  PetList({
    super.key,
    required this.products,
  });

  final List<Products> products;
  final PetController petController = Get.put(PetController());

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Center(
            child: Text('Tidak ada data'),
          )
        : GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(() => const InfoPet(), arguments: {
                    'id': products[index].id,
                    'isFromAdmin': false,
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          products[index].image!,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        products[index].name!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rp ${products[index].price}.000",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              bool res = await petController
                                  .addTocart(products[index].id);
                              if (res) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Row(
                                    children: [
                                      const Text(
                                          'Berhasil ditambahkan ke keranjang'),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.CART);
                                        },
                                        child: const Text('Lihat'),
                                      ),
                                    ],
                                  ),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Gagal ditambahkan ke keranjang'),
                                ));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.shopping_cart,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
