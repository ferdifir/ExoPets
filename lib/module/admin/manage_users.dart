import 'package:exopets/common/utils/helper.dart';
import 'package:exopets/module/admin/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageUsers extends StatelessWidget {
  const ManageUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: const SizedBox(),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: const [
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Report'),
                Tab(text: 'Users'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ReportScreen(),
                  UserScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserScreen extends StatelessWidget {
  const UserScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      init: AdminController(),
      initState: (_) {},
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.listUser.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        controller.listUser[index].profilePicture!),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.listUser[index].name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.listUser[index].email,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            controller
                                .deleteUser(controller.listUser[index].uid);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      init: AdminController(),
      initState: (_) {},
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.listReport.length,
          itemBuilder: (context, index) {
            final report = controller.listReport[index];
            return ExpansionTile(
              title: Text(report['name'] ?? 'No Title'),
              subtitle: Text(getTimeAgo(report['report_date'] ?? 0)),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(report['profile_picture'] ??
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
              ),
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  child: Text(
                    "Laporan: ${report['report_reason']}",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
