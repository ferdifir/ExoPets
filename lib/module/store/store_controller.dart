import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  Map<String, dynamic> store = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  void onInit() async {
    super.onInit();
    getMyStore();
  }

  getMyStore() async {
    final uid = _auth.currentUser!.uid;
    try {
      final response = await _dio.get('/stores/store/$uid');
      if (response.statusCode == 200) {
        var result = response.data['data'];
        printInfo(info: result.toString());
        store = result;
        update();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}