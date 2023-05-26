import 'dart:io';

import 'package:exopets/module/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileController profileController = Get.put(ProfileController());
  final Map<String, String> arguments = Get.arguments as Map<String, String>;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: profileController.userProfile == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Obx(() => Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: profileController.selectedImage.value.isEmpty
                                  ? CircleAvatar(
                                      radius: 100,
                                      backgroundImage: NetworkImage(
                                        profileController
                                                .userProfile!.profilePicture ??
                                            'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.file(
                                        File(profileController
                                            .selectedImage.value),
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
                              profileController.pickImage();
                            },
                            child: const Text('Change Profile Picture'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Name'),
                        const SizedBox(height: 4),
                        TextField(
                          controller: profileController.nameController,
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
                          controller: profileController.emailController,
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
                          controller: profileController.phoneController,
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    title: const Text('Input Your Password'),
                                    content: GetBuilder<ProfileController>(
                                      init: ProfileController(),
                                      initState: (_) {},
                                      builder: (_) {
                                        return TextField(
                                          controller: profileController.passwordController,
                                          obscureText: !profileController
                                              .isPasswordVisible,
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
                                                profileController
                                                    .togglePasswordVisibility();
                                              },
                                              icon: Icon(
                                                profileController
                                                        .isPasswordVisible
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
                                          profileController.passwordController.clear();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          String? result =
                                              await profileController
                                                  .updateProfile(
                                            name: profileController.nameController.text,
                                            email: profileController.emailController.text,
                                            phone: profileController.phoneController.text,
                                            password: profileController.passwordController.text,
                                            profilePicture: profileController
                                                .selectedImage.value,
                                            latitude: profileController
                                                .latitude.value,
                                            longitude: profileController
                                                .longitude.value,
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
                                                          Navigator.pop(
                                                              context);
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
                                                    title:
                                                        const Text('Success'),
                                                    content: const Text(
                                                        'Your profile has been updated'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          profileController
                                                                  .userProfile =
                                                              await profileController
                                                                  .getUserInfo();
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
      },
    );
  }
}
