import 'package:exopets/common/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_controller.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      init: AdminController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Manage Products'),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            centerTitle: true,
            leading: const SizedBox(),
            elevation: 0,
          ),
          backgroundColor: Colors.grey[200],
          body: ListView.builder(
            itemCount: controller.listProduct.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(controller.listProduct[index].name!),
                subtitle:
                    Text(getTimeAgo(controller.listProduct[index].createdAt!)),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        controller.listProduct[index].image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                children: [
                  ListTile(
                    title: Text(controller.listProduct[index].category!),
                    subtitle:
                        Text('Rp ${controller.listProduct[index].price}.000'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        controller.listProduct[index].isApproved == 0
                            ? IconButton(
                                onPressed: () {
                                  controller.approveProduct(
                                      controller.listProduct[index].id);
                                },
                                icon: const Icon(Icons.check),
                              )
                            : Container(),
                        IconButton(
                          onPressed: () {
                            controller.deleteProduct(
                                controller.listProduct[index].id);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
