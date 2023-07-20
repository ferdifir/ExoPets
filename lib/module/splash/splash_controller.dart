import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:exopets/module/admin/admin_page.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () async {
      bool isLogin = _auth.currentUser != null;
      if (isLogin) {
        bool isAdm = await isAdmin();
        if (isAdm) {
          Get.offAll(() => const AdminPage());
        } else {
          Get.offAllNamed(Routes.DASHBOARD);
        }
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }

  Future<bool> isAdmin() async {
    final response = await _dio.get('/admins/admin/${_auth.currentUser!.uid}');
    bool isAdm = response.data['data']['isAdmin'];
    return isAdm;
  }
}