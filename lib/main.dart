import 'package:exopets/firebase_options.dart';
import 'package:exopets/module/splash/splash_screen.dart';
import 'package:exopets/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ExoPetsApp());
}

class ExoPetsApp extends StatelessWidget {
  const ExoPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExoPets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      getPages: Pages.pages,
      defaultTransition: Transition.cupertinoDialog,
    );
  }
}