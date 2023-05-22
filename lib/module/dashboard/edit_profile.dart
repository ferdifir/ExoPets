import 'dart:io';

import 'package:exopets/module/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final DashboardController dashboardController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = dashboardController.userProfile!.name;
    emailController.text = dashboardController.userProfile!.email;
    phoneController.text = dashboardController.userProfile!.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Obx(() => Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: dashboardController.selectedImage.value.isEmpty
                        ? CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                              dashboardController.userProfile!.profilePicture ??
                                  'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                            ),
                          )
                        : ClipOval(
                            child: Image.file(
                              File(dashboardController.selectedImage.value),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                  )),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    dashboardController.pickImage();
                  },
                  child: const Text('Change Profile Picture'),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Name'),
              const SizedBox(height: 4),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Ferdi',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Email'),
              const SizedBox(height: 4),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Ferdi',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Phone Number'),
              const SizedBox(height: 4),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Ferdi',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return WillPopScope(
                        onWillPop: () async => false,
                        child: AlertDialog(
                          title: const Text('Input Your Password'),
                          content: GetBuilder<DashboardController>(
                            init: DashboardController(),
                            initState: (_) {},
                            builder: (_) {
                              return TextField(
                                controller: passwordController,
                                obscureText:
                                    !dashboardController.isPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      dashboardController
                                          .togglePasswordVisibility();
                                    },
                                    icon: Icon(
                                      dashboardController.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                passwordController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                String? result =
                                    await dashboardController.updateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  profilePicture:
                                      dashboardController.selectedImage.value,
                                  latitude: dashboardController.latitude.value,
                                  longitude:
                                      dashboardController.longitude.value,
                                );
                                Get.back();
                                if (result != null) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return WillPopScope(
                                        onWillPop: () async => false,
                                        child: AlertDialog(
                                          title: const Text('Error'),
                                          content: Text(result),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return WillPopScope(
                                        onWillPop: () async => false,
                                        child: AlertDialog(
                                          title: const Text('Success'),
                                          content: const Text(
                                              'Your profile has been updated'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                dashboardController.userProfile = await dashboardController.getUserInfo();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
