import 'package:exopets/module/dashboard/dashboard_controller.dart';
import 'package:exopets/module/dashboard/widget/dashboard_header.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardDrawer extends StatelessWidget {
  DashboardDrawer({
    Key? key,
  }) : super(key: key);

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardHeader(),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: const Text(
              'Aktivitas Saya',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            title: const Text('Checkout'),
            leading: const Icon(Icons.shopping_cart),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.CART);
            },
          ),
          ListTile(
            title: const Text('Wishlist'),
            leading: const Icon(Icons.favorite),
            onTap: () {
              Navigator.pushNamed(context, Routes.WISHLIST);
            },
          ),
          ListTile(
            title: const Text('Transaction'),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.pushNamed(context, Routes.TRANSACTION);
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: const Text(
              'Lainnya',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            title: const Text('Customer Support'),
            leading: const Icon(Icons.support_agent),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              Navigator.pushNamed(context, Routes.PRIVACY_POLICY);
            },
          ),
          ListTile(
            title: const Text('Terms & Conditions'),
            leading: const Icon(Icons.description),
            onTap: () {
              Navigator.pushNamed(context, Routes.TERMS_CONDITIONS);
            },
          ),
          ListTile(
            title: const Text('About'),
            leading: const Icon(Icons.info),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationIcon: const FlutterLogo(),
                applicationName: 'ExoPets',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2023 ExoPets',
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'ExoPets is an online store that sells various types of pets, ranging from cats, dogs, birds, and others. ExoPets also sells various types of pet food and accessories.',
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () {
                  controller.logout().then((value) {
                    Navigator.pushReplacementNamed(context, Routes.LOGIN);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

