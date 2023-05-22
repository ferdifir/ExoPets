import 'package:exopets/module/pet_list/pet_list.dart';
import 'package:exopets/model/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';
import 'widget/dashboard_drawer.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit'),
            content: const Text('Are you sure want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  SystemNavigator.pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return false;
      },
      child: SafeArea(
        child: GetBuilder<DashboardController>(
          init: DashboardController(),
          initState: (_) {},
          builder: (_) {
            if (_.userProfile == null) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Scaffold(
                appBar: buildAppBar(_),
                drawer: DashboardDrawer(),
                backgroundColor: Colors.grey[200],
                body: buildBody(context),
              );
            }
          },
        ),
      ),
    );
  }

  Container buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'Find your new pet',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Categories',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: DefaultTabController(
              length: 9,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      buildTab(Icons.pets, 'All'),
                      buildTab(Icons.pets, 'Reptil'),
                      buildTab(Icons.pets, 'Burung'),
                      buildTab(Icons.pets, 'Mamalia'),
                      buildTab(Icons.pets, 'Amfibi'),
                      buildTab(Icons.pets, 'Ikan'),
                      buildTab(Icons.pets, 'Serangga'),
                      buildTab(Icons.pets, 'Primata Kecil'),
                      buildTab(Icons.pets, 'Mamalia Kecil'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TabBarView(
                      children: [
                        PetList(products: dashboardController.products),
                        PetList(products: filterList('Reptil')),
                        PetList(products: filterList('Burung')),
                        PetList(products: filterList('Mamalia')),
                        PetList(products: filterList('Amfibi')),
                        PetList(products: filterList('Ikan')),
                        PetList(products: filterList('Serangga')),
                        PetList(products: filterList('Primata Kecil')),
                        PetList(products: filterList('Mamalia Kecil')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Products> filterList(String category) {
    return dashboardController.products.where((element) => element.category == category).toList();
  }

  AppBar buildAppBar(DashboardController _) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      centerTitle: true,
      title: InkWell(
        onTap: () {
          dashboardController.getLocation();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.location_on),
            const SizedBox(width: 8),
            Obx(() => Text(dashboardController.cityName.value)),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      actions: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey[300],
          backgroundImage: NetworkImage(
            _.userProfile!.profilePicture ??
                'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Tab buildTab(
    IconData icon,
    String text,
  ) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.blue,
          ),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
