import 'package:exopets/module/pet_list/pet_list.dart';
import 'package:exopets/model/products.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                drawer: DashboardDrawer(),
                backgroundColor: Colors.grey[200],
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.grey[200],
                        elevation: 0,
                        title: InkWell(
                          onTap: () {
                            dashboardController.getLocation();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(Icons.location_on),
                                const SizedBox(width: 8),
                                Obx(() =>
                                    Text(dashboardController.cityName.value)),
                                const SizedBox(width: 8),
                                const Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.all(4),
                          child: IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                        actions: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: NetworkImage(
                              _.userProfile!.profilePicture ??
                                  'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                        floating: true,
                        pinned: true,
                        snap: true,
                        expandedHeight: 220.0,
                        flexibleSpace: buildSpaceBar(context),
                      ),
                    ];
                  },
                  body: buildBody(context),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  FlexibleSpaceBar buildSpaceBar(BuildContext context) {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
        color: Colors.grey[200],
        child: CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.0,
            autoPlay: true,
          ),
          items: imgList
              .map(
                (item) => Center(
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
                ),
              )
              .toList(),
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
            'Temukan Teman Barumu Disini',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 16),
          TextFormField(
            onTap: () => Get.toNamed(Routes.SEARCH),
            readOnly: true,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              hintText: 'Cari hewan peliharaan yang kamu inginkan',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
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
    return dashboardController.products
        .where((element) => element.category == category)
        .toList();
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

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
