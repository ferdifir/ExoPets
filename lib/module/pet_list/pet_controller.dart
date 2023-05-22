import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PetController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> addTocart(int pid) async {
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.post('/carts/cart', data: {
        'uid': uid,
        'pid': pid,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      printError(info: e.toString());
      return false;
    }
  }
}
