import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Lottie.asset(
              'assets/animations/lady_with_cat.json',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          ListTile(
            title: const Text('Cart'),
            leading: const Icon(Icons.shopping_cart),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Wishlist'),
            leading: const Icon(Icons.favorite),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Transaction'),
            leading: const Icon(Icons.list),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () {},
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
