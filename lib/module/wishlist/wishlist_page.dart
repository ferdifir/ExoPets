import 'package:exopets/module/info/info_pet.dart';
import 'package:exopets/module/wishlist/wishlist_controller.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

  final controller = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.grey[200],
        body: GetBuilder<WishlistController>(
          init: WishlistController(),
          initState: (_) {},
          builder: (_) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: controller.wishlist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await controller.getWishlist();
                      Get.to(() => const InfoPet(),
                          arguments: {
                            'id': controller.wishlist[index]['product_id'],
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
                              controller.wishlist[index]['image'],
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            controller.wishlist[index]['product_name'],
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
                                "Rp ${controller.wishlist[index]['price']}.000",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  bool res = await controller
                                      .addTocart(controller.wishlist[index]
                                          ['pid']);
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
                                      content: Text('Gagal ditambahkan ke keranjang'),
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
              ),
            );
          },
        ));
  }
}
