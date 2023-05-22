import 'package:exopets/module/splash/splash_controller.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      controller.isLogin()
          ? Get.offAllNamed(Routes.DASHBOARD)
          : Get.offAllNamed(Routes.LOGIN);
      controller.dispose();
      controller.onDelete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/splash_light.png'),
        ),
      ),
    );
  }
}
