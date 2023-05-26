import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  bool isAdm = false;

  bool isLogin() {
    return _auth.currentUser != null;
  }

  @override
  void onInit() async {
    super.onInit();
    isAdm = await isAdmin();
    update();
  }

  Future<bool> isAdmin() async {
    final response = await _dio.get('/admins/admin/${_auth.currentUser!.uid}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}