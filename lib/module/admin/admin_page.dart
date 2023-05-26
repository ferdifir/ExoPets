import 'package:exopets/module/admin/admin_controller.dart';
import 'package:exopets/module/admin/manage_orders.dart';
import 'package:exopets/module/admin/manage_products.dart';
import 'package:exopets/module/admin/manage_users.dart';
import 'package:exopets/module/auth/admin_login.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AdminController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Admin Dashboard'),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            centerTitle: true,
            leading: const SizedBox(),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  controller.logout().then((_) {
                    Get.offAll(() => const AdminLogin());
                  });
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          backgroundColor: Colors.grey[200],
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 6),
                  child: Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.getListProduct().then((_) {
                          Get.to(() => const ManageProducts());
                        });
                      },
                      child: buildItemAdmin(
                        context,
                        'Manage\nProducts',
                        Icons.shopping_bag,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.getTransactions().then((_) {
                          Get.to(() => const ManageOrder());
                        });
                      },
                      child: buildItemAdmin(
                        context,
                        'Manage\nOrders',
                        Icons.shopping_cart,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.getAllUser().then((_) {
                          Get.to(() => const ManageUsers());
                        });
                      },
                      child: buildItemAdmin(
                        context,
                        'Manage\nUsers',
                        Icons.people,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.EDIT_PROFILE,
                          arguments: {
                            'name': 'John Doe',
                            'email': '',
                            'phone': '',
                          }
                        );
                      },
                      child: buildItemAdmin(
                        context,
                        'Edit\nProfile',
                        Icons.person,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildItemAdmin(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
