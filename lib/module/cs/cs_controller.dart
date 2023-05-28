import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CsController extends GetxController {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  final FirebaseAuth _auth = FirebaseAuth.instance;

  sendReport(String report) async {
    final String uid = _auth.currentUser!.uid;
    try {
      final response = await _dio.post('/users/report', data: {
        'user_id': uid,
        'report': report,
      });
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Report sent');
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to send report');
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
