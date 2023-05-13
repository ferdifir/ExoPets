import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        const CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'johndoe@gmail.com',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '+62 812-3456-7890',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Settings'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.STORE);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Toko Saya'),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
          ListTile(
            title: const Text('Checkout'),
            leading: const Icon(Icons.shopping_cart),
            onTap: () {
              Navigator.pushNamed(context, Routes.CHECKOUT);
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
                applicationLegalese: '© 2021 ExoPets',
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
                  Navigator.pushReplacementNamed(context, Routes.LOGIN);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
