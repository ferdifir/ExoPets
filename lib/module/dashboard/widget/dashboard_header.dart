import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard_controller.dart';

class DashboardHeader extends StatelessWidget {
  DashboardHeader({
    Key? key,
  }) : super(key: key);

  bool isAdmin = true;
  final DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
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
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      dashboardController.userProfile!.profilePicture ??
                          'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dashboardController.userProfile!.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dashboardController.userProfile!.email,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        dashboardController.userProfile!.phone,
                        style: const TextStyle(
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
                  Navigator.pushNamed(context, Routes.EDIT_PROFILE);
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          isAdmin
              ? Row(
                  children: [
                    buildRouteToStore(context),
                    InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        // Navigator.pushNamed(context, Routes.ADMIN);
                        dashboardController.getMyStore();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.only(left: 8, right: 16),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: const [
                                Icon(
                                  Icons.admin_panel_settings,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text('Admin Page'),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : buildRouteToStore(context),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  InkWell buildRouteToStore(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (dashboardController.store.isNotEmpty) {
          Navigator.pushNamed(context, Routes.STORE);
        } else {
          Navigator.pushNamed(context, Routes.CREATE_STORE);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(left: 16, right: 8),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: const [
                Icon(
                  Icons.store,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text('Toko Saya'),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
