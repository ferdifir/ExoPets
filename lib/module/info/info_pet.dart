import 'package:exopets/common/widget/custome_back_button.dart';
import 'package:exopets/module/info/info_pet_controller.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoPet extends StatefulWidget {
  const InfoPet({super.key});

  @override
  State<InfoPet> createState() => _InfoPetState();
}

class _InfoPetState extends State<InfoPet> {
  final controller = Get.put(InfoPetController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: GetBuilder(
              initState: (_) {},
              builder: (_) {
                if (_.pet.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        height: size.height * 0.4,
                        width: size.width,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      controller.pet['image'] ??
                                          'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              right: 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomBackButton(),
                                  controller.isFromAdmin
                                      ? Container()
                                      : Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(36),
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              if (_.isWishlist) {
                                                _.removeFromWishlist();
                                              } else {
                                                _.addToWishlist();
                                              }
                                            },
                                            icon: Icon(
                                              _.isWishlist
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        controller.pet['product_name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                          Text(
                            '${controller.distance.toStringAsFixed(2)} km',
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.pet['category'],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Rp ${controller.pet['price']}.000',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'AGE',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "${controller.pet['age']} bulan",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'HEALTH',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  controller.pet['health'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'SEX',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  controller.pet['sex'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'LOCATION',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        controller.pet['alamat'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'DETAILS',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        controller.pet['details'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'SELLERS',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        onTap: () {
                          Get.toNamed(
                            Routes.STORE,
                            arguments: controller.pet['uid'],
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        tileColor: Colors.grey[200],
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(
                                controller.pet['profile_picture'] ??
                                    'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          controller.pet['nama_toko'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          controller.pet['alamat'],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'View Profile',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  );
                }
              },
              init: InfoPetController(),
            ),
          ),
        ),
        floatingActionButton: controller.isFromAdmin
            ? Container()
            : MaterialButton(
                onPressed: () async {
                  controller.addTocart().then((response) {
                    if (response) {
                      Get.snackbar(
                        'Berhasil',
                        'Berhasil menambahkan ke keranjang',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    } else {
                      Get.snackbar(
                        'Gagal',
                        'Gagal menambahkan ke keranjang',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  });
                },
                color: Colors.blue,
                minWidth: size.width * 0.9,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Tambahkan ke keranjang',
                  style: TextStyle(color: Colors.white),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
